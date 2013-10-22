From: thierry.reding@gmail.com (Thierry Reding)
Date: Tue, 22 Oct 2013 22:12:29 +0200
Subject: [Ksummit-2013-discuss] ARM topic: Is DT on ARM the solution, or
 is there something better?
In-Reply-To: <alpine.LFD.2.03.1310221333300.1951@syhkavp.arg>
References: <52644A9E.3060007@wwwdotorg.org>
 <20131020220839.GT2443@sirena.org.uk>
 <5264576F.6050307@wwwdotorg.org>
 <alpine.LFD.2.03.1310201911190.1951@syhkavp.arg>
 <52658EBC.8020800@wwwdotorg.org>
 <alpine.LFD.2.03.1310211632460.1951@syhkavp.arg>
 <20131022093923.GC15640@ulmo.nvidia.com>
 <20131022150426.GF29341@beef>
 <alpine.LFD.2.03.1310221333300.1951@syhkavp.arg>
Message-ID: <20131022201228.GB8037@mithrandir>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 22, 2013 at 01:42:48PM -0400, Nicolas Pitre wrote:
> On Tue, 22 Oct 2013, Matt Porter wrote:
> 
> > DT has many benefits. It would be great to leverage them as long as it
> > doesn't interfere with the rate of change and willingness to evolve code
> > that's always been the strength of the kernel process. That strength is
> > too valuable to trade away for the "DT as ABI" vision.
> 
> Amen.  This is the best statement I've read about DT so far.
> 
> Having "stable" DT bindings is just a dream.  Experience so far is 
> showing that this is neither practical nor realistic.
> 
> The unstructured free-for-all approach isn't good either.  Some 
> compromise between the two extremes needs to be found.

I agree. I think we need an easy way to mark bindings as unstable. One
possible solution that I can think of would be to use some kind of
special marker within the compatible value defined by a binding that
would be used to qualify it as unstable. Perhaps something as simple as
a preceding exclamation mark (!) would do.

	gpio {
		compatible = "!foo-gpio";
	};

The DT core code could look for that when matching device nodes to the
list of compatible values supported by a driver and output a big warning
message to make users aware of the fact that the binding may change. The
driver could use the same marker in the OF device ID table to make it
clear that it implements an experimental binding. Whenever a binding is
deemed stable we can simply remove the marker from both the driver and
the binding, as well as DTS files.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131022/e9ee938b/attachment.sig>
