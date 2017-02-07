From: f.fainelli@gmail.com (Florian Fainelli)
Date: Tue, 7 Feb 2017 15:09:16 -0800
Subject: [PATCH v2] somedriver: remove the initialization of static
 pointers.
In-Reply-To: <1486504570-5811-1-git-send-email-abdallah.meziti.pro@gmail.com>
References: <1486504570-5811-1-git-send-email-abdallah.meziti.pro@gmail.com>
Message-ID: <b66303e8-7a25-6bc9-ba73-62dc8250c277@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/07/2017 01:55 PM, AbdAllah-MEZITI wrote:
> In C a static pointer will be initialized to NULL.
> The ?6.7.8 of the ISO/IEC 9899:1999 (E) document says that:
> If an object that has static storage duration is not initialized
> explicitly, then:
>  __ if it has pointer type, it is initialized to a null pointer.

The commit subject should be based on previous submissions, if you do a
git log --oneline drivers/staging/bcm2835-audio/bcm2835.c you will see
that the most frequent subject used was:

Staging: bcm2835-audio:

So you should utilize the same subject prefix, and make your prefix be
something like:

Staging: bcm2835-audio: Remove the initialization of static pointers

> 
> Signed-off-by: AbdAllah-MEZITI <abdallah.meziti.pro@gmail.com>
> 
> v2: -fix the line-wrapping of the changelog.
>     -fix the ref. documentation: C99 standards release,
> 	and not the draft.
>     -this patch is the Task 10 Eudyptula Challenge
> 	that only fix one code style problem.
> ---
>  drivers/staging/bcm2835-audio/bcm2835.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/bcm2835-audio/bcm2835.c b/drivers/staging/bcm2835-audio/bcm2835.c
> index a84d74d..265fe55 100644
> --- a/drivers/staging/bcm2835-audio/bcm2835.c
> +++ b/drivers/staging/bcm2835-audio/bcm2835.c
> @@ -28,8 +28,8 @@
>   * to debug if we run into issues
>   */
>  
> -static struct snd_card *g_card = NULL;
> -static struct bcm2835_chip *g_chip = NULL;
> +static struct snd_card *g_card;
> +static struct bcm2835_chip *g_chip;
>  
>  static int snd_bcm2835_free(struct bcm2835_chip *chip)
>  {
> 


-- 
Florian
