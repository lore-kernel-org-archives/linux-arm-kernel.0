From: eric@anholt.net (Eric Anholt)
Date: Thu, 09 Jun 2016 10:22:27 -0700
Subject: [PATCH 27/32] gpio: Add support for the FXL6408 GPIO expander.
In-Reply-To: <CACRpkdax3AmnprT48zL7J92ddMvLYeRXi9OrQK_JrBT8_zZQoA@mail.gmail.com>
References: <1464817421-8519-1-git-send-email-kraxel@redhat.com>
 <1464817421-8519-28-git-send-email-kraxel@redhat.com>
 <CACRpkdax3AmnprT48zL7J92ddMvLYeRXi9OrQK_JrBT8_zZQoA@mail.gmail.com>
Message-ID: <878tyexooc.fsf@eliezer.anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Linus Walleij <linus.walleij@linaro.org> writes:

> On Wed, Jun 1, 2016 at 11:43 PM, Gerd Hoffmann <kraxel@redhat.com> wrote:
>
>> +#define FXL6408_OUTPUT                 0x05
>> +/* Bits here make the output High-Z, instead of the OUTPUT value. */
>> +#define FXL6408_OUTPUT_HIGH_Z          0x07
> (...)
>> +       /* Disable High-Z of outputs, so that our OUTPUT updates
>> +        * actually take effect.
>> +        */
>> +       i2c_smbus_write_byte_data(client, FXL6408_OUTPUT_HIGH_Z, 0);
>
> High-Z is probably the same as open drain right? And if not open drain,
> it is push-pull.
>
> So you want to implement .set_single_ended() for configuring the lines in
> "high-z", i.e. open drain output mode.

I'll keep this in mind for whenever I end up writing my next GPIO
driver, but this one is dead for now (not actually usable because of the
closed firmware).
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 818 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160609/e492d675/attachment-0001.sig>
