From: cjb@laptop.org (Chris Ball)
Date: Fri, 22 Mar 2013 12:41:00 -0400
Subject: FW: Regulator API ignored return values
In-Reply-To: <87y5dsheqo.fsf@octavius.laptop.org> (Chris Ball's message of
 "Tue, 12 Mar 2013 10:30:55 -0400")
References: <25B60CDC2F704E4E9D88FFD52780CB4C0BDEB0547F@SC-VEXCH1.marvell.com>
 <CADz5_g+KfxL43BKKsgZZ3Xg4sZWE4-ZaFpFhphKrfj9yK59-XA@mail.gmail.com>
 <201303121403.09315.arnd@arndb.de>
 <87y5dsheqo.fsf@octavius.laptop.org>
Message-ID: <87d2uro09v.fsf@octavius.laptop.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Mar 12 2013, Chris Ball wrote:
> On Tue, Mar 12 2013, Arnd Bergmann wrote:
>>> Need add regulator_put here since regulator_get has succeed?
>>
>> Hmm, we still don't actually bail out if the error is encountered, so
>> the reference count is balanced with the current patch, but I maybe
>> a failed regulator_enable() should actually be a fatal error?
>
> The reason I didn't make it a fatal error is that this is just vqmmc
> (responsible for moving from 3.3V to 1.8V for UHS modes), not the
> main vmmc regulator.  We can just disable those UHS modes from the
> capabilities on the host if vqmmc is missing, or failed to enable,
> or doesn't support those voltages, and that's what the code does now.

I've pushed this patch to mmc-next for 3.10 now, let me know if you
disagree.

Thanks,

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
