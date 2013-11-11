From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 11 Nov 2013 19:32:36 +0000
Subject: kernel BUG at kernel/kallsyms.c:222!
In-Reply-To: <528110B1.4060402@arm.com>
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
Message-ID: <20131111193236.GB16735@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 11, 2013 at 05:15:29PM +0000, Jonathan Austin wrote:
> I've tested the patch below and it solves the ARM side of things - so
> gives you an option other than a complete revert. Happy to put this in to
> RMK's patch system if you'd prefer not to have to revert and he's happy
> with the patch.

I think this is the right solution because it then means that this symbol
has the same meaning whether on MMU or !MMU - and getting rid of these
kinds of gratuitous variances are the only way that !MMU is going to
become less fragile.
