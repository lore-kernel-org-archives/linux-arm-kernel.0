From: tom.leiming@gmail.com (Ming Lei)
Date: Tue, 12 Nov 2013 11:22:44 +0800
Subject: kernel BUG at kernel/kallsyms.c:222!
In-Reply-To: <20131111193236.GB16735@n2100.arm.linux.org.uk>
References: <CACVXFVNHryPXy2NQhPwXkoCeLUXQSgrWmgBkMNtGD_=X_62_5Q@mail.gmail.com>
 <CAFRkauDGiy3yZOwKFWMEJvYUe0OoXMEZHKaxogZHdgzMxexdHA@mail.gmail.com>
 <CACVXFVMAnewCkSNNke3kf1-yO+JCc_HBRp8iaLBPJ+14G79Haw@mail.gmail.com>
 <87y54vzszo.fsf@rustcorp.com.au>
 <CAFRkauBYUq3UAjqLvkuDVEz5BVyDpC0DuVRGTe4K+kcoCX17GA@mail.gmail.com>
 <CACVXFVMvvG1unnR0rsmBMdp9p19Q3JRbURxZF-UWxvrThDPKTw@mail.gmail.com>
 <CAFRkauCW3FDSuh4t0gvmSWH1m0+qaG0XSoBxmk30Wq1FMy7iFw@mail.gmail.com>
 <CACVXFVMzOzD+D-MQCUBvC80d4zS-TJfcucKuUvzerGs6gT1fEg@mail.gmail.com>
 <CACVXFVOnVXcVdRCm=OfPjpvvWCiXi8GRV+9ViOGmSZ3tTf6WDg@mail.gmail.com>
 <528110B1.4060402@arm.com>
 <20131111193236.GB16735@n2100.arm.linux.org.uk>
Message-ID: <CACVXFVPQfUtrc4r4cS9J+6q5Z6hGZDgafH=M_6JfrzrAUGJOHw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 12, 2013 at 3:32 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Mon, Nov 11, 2013 at 05:15:29PM +0000, Jonathan Austin wrote:
>> I've tested the patch below and it solves the ARM side of things - so
>> gives you an option other than a complete revert. Happy to put this in to
>> RMK's patch system if you'd prefer not to have to revert and he's happy
>> with the patch.
>
> I think this is the right solution because it then means that this symbol
> has the same meaning whether on MMU or !MMU - and getting rid of these
> kinds of gratuitous variances are the only way that !MMU is going to
> become less fragile.

The patch only fixes problem on arm, and other !MMU&&!ARM archs
should be affected too.

Also there is no CONFIG_PAGE_OFFSET defined for some ARCHs,
such as 64bit ARCHs.

Currently, I suggest to filter only on ARM as attachment patch if we plan
to merge Jonathan's patch, otherwise a more complicated approach has
to be figured out  to do the filter(such as, define a readonly symbol in
kernel to store PAGE_OFFSET, and let scripts/kallsyms use it for
filtering).



Thanks,
-- 
Ming Lei
-------------- next part --------------
A non-text attachment was scrubbed...
Name: filter-only-on-arm.patch
Type: text/x-patch
Size: 531 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131112/66bf6a2d/attachment.bin>
