From: linux@prisktech.co.nz (Tony Prisk)
Date: Thu, 14 Mar 2013 18:59:21 +1300
Subject: [Bulk] Re: [PATCH 2/6] pinctrl: gpio: vt8500: Add pincontrol
 driver for arch-vt8500
In-Reply-To: <CACRpkdauBPbOwk9fjmrwZx_t7dwLyeHznG7U_ebg=T36uLF-cw@mail.gmail.com>
References: <1362807578-23089-1-git-send-email-linux@prisktech.co.nz>
 <1362807578-23089-3-git-send-email-linux@prisktech.co.nz>
 <513E09FE.5040104@wwwdotorg.org> <1363062095.23051.16.camel@gitbox>
 <CACRpkdYTKk-fPkUX_jOoHoqxgpsEh2L1ryGC7VSNiAbsmOtcEg@mail.gmail.com>
 <1363201721.2452.8.camel@gitbox>
 <CACRpkdauBPbOwk9fjmrwZx_t7dwLyeHznG7U_ebg=T36uLF-cw@mail.gmail.com>
Message-ID: <1363240761.6220.7.camel@gitbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2013-03-13 at 20:13 +0100, Linus Walleij wrote:
> On Wed, Mar 13, 2013 at 8:08 PM, Tony Prisk <linux@prisktech.co.nz> wrote:
> 
> > The only reason we use this register at present is to enable the LCD
> > selection (bit 0 in this example - bit 31 on the other SoCs).
> 
> OK then I guess there is not immediate need for that to be in
> the device tree right now? I'm happy if you open-code that.

Sorry - don't understand the meaning of 'open-code'. Could you elaborate
on what you mean.

I only included the pinmux property so we could remove the requirement
for arch-vt8500/vt8500.c to find a gpio DT node and modify this register
(Patch 6).

If it's going to cause too many headaches implementing this particular
bit, it could be dropped and the code stay in vt8500.c - I just wanted
to move the code to where it should belong.

> 
> > Other than that, we rely on uboot to have 'done the right thing'.
> 
> Do you have the U-boot sources to inspect on how this works
> then? You are legally entitled to them...

We have some uboot sources - although they are piecemeal and getting
source code from Wondermedia is difficult to say the least.

Example reply from Wondermedia:

Hi Tony Prisk,

       I m a Sr. engineer of Wondermedia company, any technical question
you can ask me. About Linux kernel Source of Android 4.0, We don?t
release the linux kernel source code, for the most of customer cant
develop the program by themself, if we open the source code, they also
cant make development on our platform. They will ask many and many
question.So we only release linux kernel source code to big company,
such as pansonic, sony &...
       If you also need linux kernel source code, you should Sign NDA
with our company and depend on the quantity of tablet you buy. If you
have any question, you can ask me.

BR

??? Mason liu
CS-AP R&D-Hardware Dept.
Sr.HW


To which I basically said 'No I won't sign an NDA', and he came back and
said 'No you can't have the source'.

> 
> Or do you mean some earlier proprietary step has set them
> up, or something like power-on state? Then I'm following...

Some of it is done in w-boot (no source code released, runs before
u-boot), other stuff is power-on default.

> 
> Yours,
> Linus Walleij
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
