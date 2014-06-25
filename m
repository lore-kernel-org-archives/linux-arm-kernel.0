From: dianders@chromium.org (Doug Anderson)
Date: Wed, 25 Jun 2014 11:06:30 -0700
Subject: [PATCH v3 04/14] clk: max77686: Improve Maxim 77686 PMIC clocks
 binding
In-Reply-To: <1403202040-12641-5-git-send-email-javier.martinez@collabora.co.uk>
References: <1403202040-12641-1-git-send-email-javier.martinez@collabora.co.uk>
 <1403202040-12641-5-git-send-email-javier.martinez@collabora.co.uk>
Message-ID: <CAD=FV=VezCMpYiD6vj_SkPYVM30GWF_YiRZVGyLHDD0-EbD+7Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Javier,

On Thu, Jun 19, 2014 at 11:20 AM, Javier Martinez Canillas
<javier.martinez@collabora.co.uk> wrote:
> @@ -33,6 +38,6 @@ Example: Clock consumer node
>         foo at 0 {
>                 compatible = "bar,foo";
>                 /* ... */
> -               clock-names = "my-clock";
> -               clocks = <&max77686 2>;
> +               clock-names = "32khz_pmic";
> +               clocks = <&max77686 MAX77686_CLK_PMIC>;

A minor comment here is that you probably shouldn't change "clock-names".

The "clock-names" is the consumer's concept of the clock name and not
the producer's concept.  If this clock were specified as going into
the TPM, for instance, the TPM might call it "32k-reference".  Then
the TPM would get the clock by referring to this name in its driver.

-Doug
