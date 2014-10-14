From: geoff.levand@linaro.org (Geoff Levand)
Date: Tue, 14 Oct 2014 09:53:35 -0700
Subject: [RFC PATCH] arm64/efi: use stable virtual mappings for UEFI
 runtime services
In-Reply-To: <CAKv+Gu8v7yY6B4G69EtFmWacg=ifhTVn7cB3TEFgXpNoHhG0hQ@mail.gmail.com>
References: <1412789936-4908-1-git-send-email-ard.biesheuvel@linaro.org>
 <1413240766.31184.69.camel@smoke>
 <20141014021721.GA4201@darkstar.nay.redhat.com>
 <CAKv+Gu8v7yY6B4G69EtFmWacg=ifhTVn7cB3TEFgXpNoHhG0hQ@mail.gmail.com>
Message-ID: <1413305615.31184.81.camel@smoke>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ard,

On Tue, 2014-10-14 at 12:26 +0200, Ard Biesheuvel wrote:
> On 14 October 2014 04:17, Dave Young <dyoung@redhat.com> wrote:
> > On 10/13/14 at 03:52pm, Geoff Levand wrote:
> >> early_memremap() returns 0xFFFFFFBFFBCBF618, and the dereference
> >> starts the crash.  I did not look into it further.
> >
> > This is an expected behaviour as I mentioned before, we need save fw_vendor
> > and the other two physical addresses and pass them to 2nd kernel.
> >
> > UEFI firmware will convert them to virtual address after entering virtual mode.
> >
> 
>  Yes, you did point that out before, and I haven't addressed it in my patch.
> 
> But allow me to emphasize *again* that these issues will simply cease
> to exist if we decide to not use SetVirtualAddressMap() at all, and
> call the UEFI Runtime Services through their physical mappings.

Once you figure out what you will do, and you think you have a complete
working solution, let me know and I will test them.  I don't plan to do
any more UEFI testing until then.

-Geoff
