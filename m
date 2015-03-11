From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 11 Mar 2015 10:04:21 +0000
Subject: [PATCH 3/5] arm64: Documentation: clarify Image placement in
 physical RAM
In-Reply-To: <1425380630-3684-4-git-send-email-ard.biesheuvel@linaro.org>
References: <1425380630-3684-1-git-send-email-ard.biesheuvel@linaro.org>
 <1425380630-3684-4-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <20150311100421.GA4114@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 03, 2015 at 11:03:48AM +0000, Ard Biesheuvel wrote:
> The early init code maps the kernel image using statically
> allocated page tables. This means that we can only allow
> Image to be placed such that we can map its entire static
> footprint using a single table entry at all but the lowest
> level. So update the documentation to reflect that the Image
> should not cross a 512 MB boundary, which ensures the above
> on both 4k and 64k pages kernels.
> 
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> ---
>  Documentation/arm64/booting.txt | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/arm64/booting.txt b/Documentation/arm64/booting.txt
> index bdc35fc97ac8..49f17b1632f1 100644
> --- a/Documentation/arm64/booting.txt
> +++ b/Documentation/arm64/booting.txt
> @@ -112,8 +112,9 @@ The Image must be placed text_offset bytes from a 2MB aligned base
>  address near the start of usable system RAM and called there. Memory
>  below that base address is currently unusable by Linux, and therefore it
>  is strongly recommended that this location is the start of system RAM.
> -At least image_size bytes from the start of the image must be free for
> -use by the kernel.
> +The physical memory region consisting of image_size bytes counting from
> +the start of the image must be free for use by the kernel, and must not
> +cross a 512 MB physical alignment boundary.

This is correct.

I had a go at rewording this so as to move all the address restrictions
together, but I couldn't make it any clearer than the wording above. So
FWIW:

Reviewed-by: Mark Rutland <mark.rutland@arm.com>

Mark.
