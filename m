From: soren.brinkmann@xilinx.com (=?utf-8?B?U8O2cmVu?= Brinkmann)
Date: Tue, 28 Oct 2014 09:07:30 -0700
Subject: [PATCH RFC v2 3/8] pinctrl: pinconf-generic: Add parameter 'IO
 standard'
In-Reply-To: <CACRpkdZtqNUroNfd_0Kftq+-056YFzjvR+ROrZZ0htZX2v2qzg@mail.gmail.com>
References: <1413479495-14206-1-git-send-email-soren.brinkmann@xilinx.com>
 <1413479495-14206-4-git-send-email-soren.brinkmann@xilinx.com>
 <CACRpkdZtqNUroNfd_0Kftq+-056YFzjvR+ROrZZ0htZX2v2qzg@mail.gmail.com>
Message-ID: <62aa98fc84d14f919e35dd068d24e5a7@BN1BFFO11FD060.protection.gbl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2014-10-28 at 03:59PM +0100, Linus Walleij wrote:
> On Thu, Oct 16, 2014 at 7:11 PM, Soren Brinkmann
> <soren.brinkmann@xilinx.com> wrote:
> 
> > For HW that can select the IO standard for pins, add the infrastructure
> > in pinconf generic to parse this parameter.
> >
> > Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
> 
> Nothing in this patch actually explain what an "IO standard" is,
> which is paramount if it should be a generic property.
> 
> And if it should be generic, I really want to know why this is a
> thing not overlapping with existing generic configs, and exactly
> what it is and that it is probable other silicon will have it too.
> And we need to discuss if it's the right name.
> 
> Looking at what you actually set up, it looks very much like this
> is actually PIN_CONFIG_DRIVE_STRENGTH.

I was thinking about that, but:
drive strength is well defined saying you choose the drive strength in
mA (or some other variation of Amperes). That is not (directly) what you
can set in Zynq. In Zynq the config allows selecting IO-standards like
LVCMOS(1.8|2.5|3.3) or HSTL.
So, this might also map to a certain drive-strength, but is not really
mapping well to Zynq pin configuration options.
Hence, I thought introducing this new property which allows a more
flexible interpretation of the argument would be a better way and might
also help other pinctrl cases (though this is speculative).

	Thanks,
	S?ren
