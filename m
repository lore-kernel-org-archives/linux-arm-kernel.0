From: atull@opensource.altera.com (atull)
Date: Mon, 29 Aug 2016 09:35:36 -0500
Subject: FPGA manager: What is the proper way to load a bitstream now?
In-Reply-To: <57C3DE04.4030109@topic.nl>
References: <57C3DE04.4030109@topic.nl>
Message-ID: <alpine.DEB.2.02.1608290927380.2561@linuxheads99>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 29 Aug 2016, Mike Looijmans wrote:

> The "FPGA manager" has been around for a while now, so I thought to integrate
> it. However, there's apparently only a kernel-to-kernel interface and it isn't
> actually being used in current mainline kernels?
> 
> So far, I've been using vendor provided drivers to load the FPGA bitstream
> (e.g. "cat fpga.bin > /dev/xdevcfg") somewhere early during boot.
> 
> With the FPGA manager, while looking for a userspace interface, all I found
> were proposals to do so, that have been 'shot down', even the nice ones using
> DT overlays, and in the end, there is apparently no way whatsover to simply
> load a bitstream at boot, other that writing (yet another) driver to trigger
> the firmware load at some stage.
> 
> Is this an accurate summary of the current state, or is there something I've
> missed?
> 
> (resent because of corporate mailserver turning plaintext into HTML)
> 

Hi Mike,

There is some stuff that is not yet accepted upstream.  Please see
my tree (either branch socfpga-4.6 or socfpga-4.1.22-ltsi, take your
pick).

git clone https://github.com/altera-opensource/linux-socfpga.git

Documentation for the in-kernel API is
 Documentation/fpga/fpga-mgr.txt

Documentation for using device tree overlays is 
 Documentation/devicetree/bindings/fpga/fpga-region.txt

The in kernel device tree compiler has to be upgraded to include
some of Pantelis Antoniou's patches.

This interface uses the firmware layer to load files from the
root filesystem.  This all happens under control of applying
device tree overlays as documented in the fpga-region.txt
document.

I think the DTO stuff is close to being accepted, but that
will take time still.

Alan
