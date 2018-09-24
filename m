From: dan.carpenter@oracle.com (Dan Carpenter)
Date: Mon, 24 Sep 2018 12:58:19 +0300
Subject: [PATCH v2 4/5] staging: vc04_services: Surround complex macros
In-Reply-To: <20180923140620.14583-5-qader.aymen@gmail.com>
References: <20180923140620.14583-1-qader.aymen@gmail.com>
 <20180923140620.14583-5-qader.aymen@gmail.com>
Message-ID: <20180924095819.q3zsqspddxjlsc2e@mwanda>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Sep 23, 2018 at 03:06:19PM +0100, Aymen Qader wrote:
> This patch fixes the checkpatch.pl error:
> 
> ERROR: Macros with complex values should be enclosed in parentheses
> 
> in the interface/vchi directory
> 
> Signed-off-by: Aymen Qader <qader.aymen@gmail.com>
> ---
>  drivers/staging/vc04_services/interface/vchi/vchi.h | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/staging/vc04_services/interface/vchi/vchi.h b/drivers/staging/vc04_services/interface/vchi/vchi.h
> index d8e660240a44..f818cf2e27e1 100644
> --- a/drivers/staging/vc04_services/interface/vchi/vchi.h
> +++ b/drivers/staging/vc04_services/interface/vchi/vchi.h
> @@ -92,14 +92,14 @@ typedef struct vchi_msg_vector_ex {
>  } VCHI_MSG_VECTOR_EX_T;
>  
>  // Construct an entry in a msg vector for a pointer (p) of length (l)
> -#define VCHI_VEC_POINTER(p, l)  VCHI_VEC_POINTER, { { (VCHI_MEM_HANDLE_T)(p), (l) } }
> +#define VCHI_VEC_POINTER(p, l)  (VCHI_VEC_POINTER, { { (VCHI_MEM_HANDLE_T)(p), (l) } })
>  
>  // Construct an entry in a msg vector for a message handle (h), starting at offset (o) of length (l)
> -#define VCHI_VEC_HANDLE(h, o, l) VCHI_VEC_HANDLE,  { { (h), (o), (l) } }
> +#define VCHI_VEC_HANDLE(h, o, l) (VCHI_VEC_HANDLE,  { { (h), (o), (l) } })
>  
>  // Macros to manipulate 'FOURCC' values
>  #define MAKE_FOURCC(x) ((int32_t)((x[0] << 24) | (x[1] << 16) | (x[2] << 8) | x[3]))
> -#define FOURCC_TO_CHAR(x) (x >> 24) & 0xFF, (x >> 16) & 0xFF, (x >> 8) & 0xFF, x & 0xFF
> +#define FOURCC_TO_CHAR(x) ((x >> 24) & 0xFF, (x >> 16) & 0xFF, (x >> 8) & 0xFF, x & 0xFF)
>  

These are never used so far as I can see, but if they were, then this
would probably break the code.  Go through the git log and find out how
they used to work and if they can be removed.

regards,
dan carpenter
