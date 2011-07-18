From: eric.y.miao@gmail.com (Eric Miao)
Date: Mon, 18 Jul 2011 13:59:57 +0800
Subject: [PATCH 2/2] ARM: pxa168: gplugD: bug-fix: Free correct GPIO
In-Reply-To: <1310636236-3104-2-git-send-email-tanmay.upadhyay@einfochips.com>
References: <no>
	<1310636236-3104-2-git-send-email-tanmay.upadhyay@einfochips.com>
Message-ID: <CAMPhdO8f0e3=MDJW5GkuWY6v8dhCvdvwEa6W8ynbcFioA32Uig@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 14, 2011 at 5:37 PM, Tanmay Upadhyay
<tanmay.upadhyay@einfochips.com> wrote:
> Signed-off-by: Tanmay Upadhyay <tanmay.upadhyay@einfochips.com>

Applied to 'devel'.

> ---
> ?arch/arm/mach-mmp/gplugd.c | ? ?4 ++--
> ?1 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/mach-mmp/gplugd.c b/arch/arm/mach-mmp/gplugd.c
> index 0770e51..98e25d9 100644
> --- a/arch/arm/mach-mmp/gplugd.c
> +++ b/arch/arm/mach-mmp/gplugd.c
> @@ -162,7 +162,7 @@ static void __init select_disp_freq(void)
> ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?"frequency\n");
> ? ? ? ?} else {
> ? ? ? ? ? ? ? ?gpio_direction_output(35, 1);
> - ? ? ? ? ? ? ? gpio_free(104);
> + ? ? ? ? ? ? ? gpio_free(35);
> ? ? ? ?}
>
> ? ? ? ?if (unlikely(gpio_request(85, "DISP_FREQ_SEL_2"))) {
> @@ -170,7 +170,7 @@ static void __init select_disp_freq(void)
> ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?"frequency\n");
> ? ? ? ?} else {
> ? ? ? ? ? ? ? ?gpio_direction_output(85, 0);
> - ? ? ? ? ? ? ? gpio_free(104);
> + ? ? ? ? ? ? ? gpio_free(85);
> ? ? ? ?}
> ?}
>
> --
> 1.7.0.4
>
>
