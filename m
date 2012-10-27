From: josh.cartwright@ni.com (Josh Cartwright)
Date: Sat, 27 Oct 2012 09:42:53 -0500
Subject: [PATCH v4 1/5] zynq: use GIC device tree bindings
In-Reply-To: <4fd22fac-49c4-4000-9e70-12e94f248753@AM1EHSMHS010.ehs.local>
References: <20121024200222.GA6713@beefymiracle.amer.corp.natinst.com>
 <20121024200310.GB6713@beefymiracle.amer.corp.natinst.com>
 <0d1c4cf8-70d8-4d12-bd77-393009d32b22@CH1EHSMHS001.ehs.local>
 <20121027140053.GB5190@beefymiracle.amer.corp.natinst.com>
 <4fd22fac-49c4-4000-9e70-12e94f248753@AM1EHSMHS010.ehs.local>
Message-ID: <20121027144253.GC5190@beefymiracle.amer.corp.natinst.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Oct 27, 2012 at 02:06:45PM +0000, Michal Simek wrote:
[...]
> I am not big fan to use dtsi solution because dts can be simple generated directly
> From Xilinx design tool based on your hw design. That's why I can't see any benefit
> To have dtsi file.

Can I ask you to reconsider?  We, for example, don't make any use of the
Xilinx dev tools to generate our device trees.  Having a dtsi allows for
easy extension of the zynq-7000 platform for our boards, without having
to carry duplicate data.

Is it going to be expected that users building kernels for their zynq
targets have access to the Xilinx EDK?

> > Would you like for me to pull this into v5, or spin up a separate patch series?
>
> Definitely not. I have checked patches but haven't got it work on the zc702.
> Not sure if you have run it on real hw or just on the qemu as you have mentioned
> In 5/5.

You're likely running into the issue Nick has identified in the thread
for patch 5 where the chosen virtual address for the uart doesn't seem
to work: http://www.spinics.net/lists/arm-kernel/msg203141.html

We haven't yet identified the root cause; any insight you can provide
here would be beneficial.

Otherwise, I'm considering reworking patch 5 to move the uart mapping to
a known working location.

Thanks,

   Josh
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121027/1fdbdb53/attachment.sig>
