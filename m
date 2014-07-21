From: maggie.mae.roxas@gmail.com (Maggie Mae Roxas)
Date: Sun, 20 Jul 2014 18:57:11 -0700
Subject: Issue found in Armada 370: "No buffer space available" error
 during continuous ping
In-Reply-To: <20140717081527.GJ14723@1wt.eu>
References: <CAB8gEUs3Z8OzOMBVqP1yN8zV1E67mGQTaxKKCw=GRuAVxJ4nGQ@mail.gmail.com>
 <CAB8gEUv52mjpAuYRKhv8_VuAwt9Uog5eD2jn45gnyqcd+cXv8g@mail.gmail.com>
 <20140708102142.0f7fe796@free-electrons.com>
 <CAB8gEUvEQdRT3Xarq_z6-KCr3T9xZ7wHvW9Termw8MAg_d-gQA@mail.gmail.com>
 <20140715142431.4eccbcd6@free-electrons.com>
 <20140715124333.GF12333@1wt.eu>
 <CAB8gEUt08QVpgW0fs18tNnCkCw36SD6hxgL8O6p6+oOtX0-yJQ@mail.gmail.com>
 <20140717081527.GJ14723@1wt.eu>
Message-ID: <CAB8gEUsLmuDkTzGsq8fVs9dZ90d82Brw2cAPBOnobUTcSgQabA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Willy, Thomas,
Good day.

> I'll try this one, specifcally this combination:
> - use 3.13.9 mvneta.c
> - apply cd71e246c16b30e3f396a85943d5f596202737ba
> - revert 4f3a4f701b59a3e4b5c8503ac3d905c0a326f922

This is to confirm that "No buffer space available" issue is resolved
after I applied above combinations in in v3.13.9.
Thanks a lot for the help!

BTW, sorry for the late update - all our connections, electricity and
stuff are unstable for the past week due to typhoon and we only got
everything working just today.

Thank you again for attending to our reports.

Regards,
Maggie Roxas

On Thu, Jul 17, 2014 at 1:15 AM, Willy Tarreau <w@1wt.eu> wrote:
> Hi Maggie,
>
> On Wed, Jul 16, 2014 at 10:37:47PM -0700, Maggie Mae Roxas wrote:
>> Hi Thomas, Willy,
>> Good day.
>>
>> First of all, thanks again for looking further into this.
>>
>> > Maggie, do you know if it is possible that for any reason your board
>> > would not deliver an IRQ on Tx completion ? That could explain things.
>>
>> I'm sorrry but I'm not really sure how to check this - all I know is
>> that the difference in the working and not-working setup (both
>> software and hardware) is the mvneta.c.
>
> In fact I don't know if you're running your own board or a "standard"
> one (a mirabox or any NAS board). Because that could also be one of the
> differences between what you observe on your side and our respective
> experiences with our boards.
>
>> > You can easily test reverting commit 4f3a4f701b just in case. If that's
>> > the case, then the next step will be to figure out how it is possible
>> > that IRQs are disabled!
>> I'll try this one, specifcally this combination:
>> - use 3.13.9 mvneta.c
>> - apply cd71e246c16b30e3f396a85943d5f596202737ba
>> - revert 4f3a4f701b59a3e4b5c8503ac3d905c0a326f922
>>
>> I will update you the results within today until latest tomorrow.
>
> OK fine, thank you!
>
> Willy
>
