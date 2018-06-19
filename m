From: broonie@kernel.org (Mark Brown)
Date: Tue, 19 Jun 2018 15:13:24 +0100
Subject: next/master boot: 138 boots: 8 failed, 112 passed with 18
 offline (next-20180619)
In-Reply-To: <5b290c6d.1c69fb81.fc936.98ee@mx.google.com>
References: <5b290c6d.1c69fb81.fc936.98ee@mx.google.com>
Message-ID: <20180619141324.GD11230@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 19, 2018 at 07:00:13AM -0700, kernelci.org bot wrote:

Today and yesterday's -next is failing to boot on rk3399-firefly in two
configs:

>     defconfig:
>         rk3399-firefly:
>             lab-baylibre-seattle: failing since 1 day (last pass: next-20180615 - first fail: next-20180618)

>     defconfig+CONFIG_RANDOMIZE_BASE=y:
>         rk3399-firefly:
>             lab-baylibre-seattle: failing since 1 day (last pass: next-20180615 - first fail: next-20180618)

The log ends with:

[    2.629278] SWITCH_REG2: supplied by vcc3v3_sys
[    2.633030] fan53555-regulator 0-0040: FAN53555 Option[8] Rev[1] Detected!
[    2.633723] fan53555-reg: supplied by vcc_sys
[    2.6353|] Internal error: undefined instruction: 0 [#1] PREEMPT SMP

which is rather entertaining. 

The pending fixes -next branch is fine.  More diagnostics can be seen
at:

	https://kernelci.org/boot/id/5b28eadb59b514636d79a877/

(that's the defconfig.)  Other boards don't seem to be affected, there's
some other boards that are failing but don't seem to be related.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180619/0dbabfd4/attachment.sig>
