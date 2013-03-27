From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 27 Mar 2013 09:40:51 +0100
Subject: [Bulk] Re: [PATCH 2/6] pinctrl: gpio: vt8500: Add pincontrol
 driver for arch-vt8500
In-Reply-To: <1363240761.6220.7.camel@gitbox>
References: <1362807578-23089-1-git-send-email-linux@prisktech.co.nz>
 <1362807578-23089-3-git-send-email-linux@prisktech.co.nz>
 <513E09FE.5040104@wwwdotorg.org> <1363062095.23051.16.camel@gitbox>
 <CACRpkdYTKk-fPkUX_jOoHoqxgpsEh2L1ryGC7VSNiAbsmOtcEg@mail.gmail.com>
 <1363201721.2452.8.camel@gitbox>
 <CACRpkdauBPbOwk9fjmrwZx_t7dwLyeHznG7U_ebg=T36uLF-cw@mail.gmail.com>
 <1363240761.6220.7.camel@gitbox>
Message-ID: <CACRpkda_HWPAwR+8biP_PTNE0YVmD5DWx2jxzZn4vHY-pfC6Og@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 14, 2013 at 6:59 AM, Tony Prisk <linux@prisktech.co.nz> wrote:
> On Wed, 2013-03-13 at 20:13 +0100, Linus Walleij wrote:
>> On Wed, Mar 13, 2013 at 8:08 PM, Tony Prisk <linux@prisktech.co.nz> wrote:
>>
>> > The only reason we use this register at present is to enable the LCD
>> > selection (bit 0 in this example - bit 31 on the other SoCs).
>>
>> OK then I guess there is not immediate need for that to be in
>> the device tree right now? I'm happy if you open-code that.
>
> Sorry - don't understand the meaning of 'open-code'. Could you elaborate
> on what you mean.

To open-code is to write the information into the code as e.g. constants
instead of stashing it into the device tree.

> I only included the pinmux property so we could remove the requirement
> for arch-vt8500/vt8500.c to find a gpio DT node and modify this register
> (Patch 6).
>
> If it's going to cause too many headaches implementing this particular
> bit, it could be dropped and the code stay in vt8500.c - I just wanted
> to move the code to where it should belong.

I think this is better.

The problem is that if you add this to the DT, it will need to be
supported forever, we are not allowed to remove bindings from the
device tree, one day when we understand it.

> Example reply from Wondermedia:
>
> Hi Tony Prisk,
>
>        I m a Sr. engineer of Wondermedia company, any technical question
> you can ask me. About Linux kernel Source of Android 4.0, We don?t
> release the linux kernel source code, for the most of customer cant
> develop the program by themself, if we open the source code, they also
> cant make development on our platform. They will ask many and many
> question.So we only release linux kernel source code to big company,
> such as pansonic, sony &...

Hm there is some education about how the community works to be
done at this company.

It is by universal misunderstanding that we agree with each other.
If, by some misfortune, we understood each other, we would never agree.
(Baudelaire.)

So we get all the fun of reverse-engineering instead, well whatever :-/

>> Or do you mean some earlier proprietary step has set them
>> up, or something like power-on state? Then I'm following...
>
> Some of it is done in w-boot (no source code released, runs before
> u-boot), other stuff is power-on default.

OK. I get it, I think.

Yours,
Linus Walleij
