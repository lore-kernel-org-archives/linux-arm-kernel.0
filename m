From: javier@dowhile0.org (Javier Martinez Canillas)
Date: Mon, 25 Aug 2014 11:33:35 +0200
Subject: [PATCH 2/2] input: cros_ec_keyb: Add of match table
In-Reply-To: <1408952050.31096.5.camel@collabora.co.uk>
References: <1408748582-29029-1-git-send-email-sjoerd.simons@collabora.co.uk>
 <1408748582-29029-3-git-send-email-sjoerd.simons@collabora.co.uk>
 <53F89A52.60605@cogentembedded.com>
 <1408952050.31096.5.camel@collabora.co.uk>
Message-ID: <CABxcv=n0J+xXJpD7d0nZj-urXND-i1yCNMQuG2E4LN_sD5gUbQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Mon, Aug 25, 2014 at 9:34 AM, Sjoerd Simons
<sjoerd.simons@collabora.co.uk> wrote:
>> >
>> >   static SIMPLE_DEV_PM_OPS(cros_ec_keyb_pm_ops, NULL, cros_ec_keyb_resume);
>> >
>> > +#ifdef CONFIG_OF
>> > +static const struct of_device_id cros_ec_keyb_of_match[] = {
>
>>     Perhaps better to use '__maybe_unused' instead of #ifdef...
>
> Hmm, looks like the rtc-ds1742.c driver is the only one in the kernel
> tree using that strategy, while all others use #ifdef CONFIG_OF. So i'm
> inclined to keep the #ifdef here, ooi what is your rationale behind
> suggesting __maybe_unused?
>

I agree with Sjoerd on this. Not only using the #ifdef guards makes it
more evident when reading the code that this depends on OF being
enabled but also if using __maybe_unused an entry in the struct
of_device_id table will be added for no reason.

>
>> > +   { .compatible = "google,cros-ec-keyb" },
>> > +   {},
>> > +};
>> > +MODULE_DEVICE_TABLE(of, cros_ec_keyb_of_match);
>> > +#endif
>> > +
>> > +
>>
>>     Too many empty lines.
>
>
>
>> >   static struct platform_driver cros_ec_keyb_driver = {
>> >     .probe = cros_ec_keyb_probe,
>> >     .driver = {
>> >             .name = "cros-ec-keyb",
>> > +           .of_match_table = of_match_ptr (cros_ec_keyb_of_match),
>>
>>     There shouldn't be space before (.
>
> Will fix the identation issues in a v2.
>
> Thanks for the review,
>  Sjoerd

After fixing the empty lines:

Reviewed-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>

Best regards,
Javier
