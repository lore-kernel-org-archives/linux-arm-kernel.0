From: dave.martin@linaro.org (Dave Martin)
Date: Sun, 13 Mar 2011 11:08:22 +0000
Subject: compiling 2.6.37 kernel in THUMB2 mode
In-Reply-To: <AANLkTintEi=JO222wQARaacpfHPor5usnz-qhNAAFXjm@mail.gmail.com>
References: <AANLkTi=bJwvTMk0B9N5AAbkNXEh_Wmvu75qrdHeL2Rrh@mail.gmail.com>
	<alpine.LFD.2.00.1102152257500.14920@xanadu.home>
	<AANLkTinQzK=s_r+_uaNRkq4MTPcF4zVE2aHPx5cqwYAN@mail.gmail.com>
	<AANLkTi=PLJBZ=Q-4k8ZUbX4S3w7f3WfUd9acb7iVYGBP@mail.gmail.com>
	<AANLkTi=_=jzs+MrvGbwF3L0c_eSq4nnbqE-xZ_+Z5fgH@mail.gmail.com>
	<AANLkTinKhCG4HauFHrPd=qr9vmVheH59vu2Be=tWoJft@mail.gmail.com>
	<AANLkTik1FY=K1Wuo=vnh5xuq6aS1x2d2Km=ByrCSufJC@mail.gmail.com>
	<AANLkTi=3s6ZRkaBG4uaS=7kaLWD-q2MgN0cN1otBrcmy@mail.gmail.com>
	<AANLkTikG=euGb1f4v50p9xwYtSuZ78aRgJ6XTfxy0TPR@mail.gmail.com>
	<AANLkTintEi=JO222wQARaacpfHPor5usnz-qhNAAFXjm@mail.gmail.com>
Message-ID: <AANLkTi=RQ3-ZkDKPOByGsey-E45cVA-5Rj3zWOjLutiy@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Mar 12, 2011 at 12:14 AM,  <vb@vsbe.com> wrote:
> On Fri, Mar 11, 2011 at 2:44 PM, ?<vb@vsbe.com> wrote:
>>
>> boot.ok:usb 3-1.4: SerialNumber: 07A80C01174E078E
>> boot.th:usb 3-1.4: SerialNumber: 07AA08011D51D473
>>
>
> oh, geez, this is embarrassing - please disregard this 'clue', but th
> rest of mystery remains - linux does not boot all the way...

All C code "should just work", so I'd be surprised if generic driver
stacks like USB got broken (for example). The most likely cause of
problems is that there is some mach/ or plat/ code containing some
assembler which is not Thumb-compatible.

For example, the power management code in plat-omap and mach-omap2 has
some issues of this type.  This prevented successful bootup, as well
as preventing power management operations from working properly until
the code was fixed.

For a list of all the patches which could be relevant, try grepping
the history of the linaro 2.6.38 tree
(git://git.linaro.org/kernel/linux-linaro-2.6.38.git master) for
anything matching "thumb".  The non-omap specific patches are relevant
to you -- pretty much everything is upstream or in Russell's tree now.
 The omap-specific patches will be a useful illustration of the kind
of problems you might encounter with the BSP.

Hope that helps
---Dave
