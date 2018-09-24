From: dan.carpenter@oracle.com (Dan Carpenter)
Date: Mon, 24 Sep 2018 13:02:06 +0300
Subject: [PATCH v2 5/5] staging: vc04_services: Remove spaces after '*'
In-Reply-To: <20180923140620.14583-6-qader.aymen@gmail.com>
References: <20180923140620.14583-1-qader.aymen@gmail.com>
 <20180923140620.14583-6-qader.aymen@gmail.com>
Message-ID: <20180924100206.dhbdz4fbrmba3dwh@mwanda>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Sep 23, 2018 at 03:06:20PM +0100, Aymen Qader wrote:
> This patch fixes the checkpatch.pl error:
> 
> ERROR: "foo * bar" should be "foo* bar"
                                ^^^^^^^^
It should be "foo *bar".

> 
> in the interface/vchi directory
> 
> Signed-off-by: Aymen Qader <qader.aymen@gmail.com>
> ---
>  drivers/staging/vc04_services/interface/vchi/vchi.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/vc04_services/interface/vchi/vchi.h b/drivers/staging/vc04_services/interface/vchi/vchi.h
> index f818cf2e27e1..77bf92018165 100644
> --- a/drivers/staging/vc04_services/interface/vchi/vchi.h
> +++ b/drivers/staging/vc04_services/interface/vchi/vchi.h
> @@ -154,7 +154,7 @@ typedef struct service_info_tag {
>  extern "C" {
>  #endif
>  
> -extern /*@observer@*/ VCHI_CONNECTION_T * vchi_create_connection(const VCHI_CONNECTION_API_T * function_table,
                                                                                                ^^^^^^^^^^^^^^^^^
> +extern /*@observer@*/ VCHI_CONNECTION_T *vchi_create_connection(const VCHI_CONNECTION_API_T * function_table,
>  								 const VCHI_MESSAGE_DRIVER_T * low_level);
                                                                                             ^^^^^^^^^^^

Change these as well.

regards,
dan carpenter
