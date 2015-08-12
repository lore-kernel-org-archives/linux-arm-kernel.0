From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Wed, 12 Aug 2015 12:41:31 +0100
Subject: [PATCH v8 3/4] drivers: nvmem: Add Vybrid OCOTP support
In-Reply-To: <20150812113203.GA15470@Sanchayan-Arch.toradex.int>
References: <cover.1439214648.git.maitysanchayan@gmail.com>
 <29b527f1897b24a310a3f3acee61c721d3399503.1439214648.git.maitysanchayan@gmail.com>
 <55CB22F3.2000702@linaro.org>
 <20150812113203.GA15470@Sanchayan-Arch.toradex.int>
Message-ID: <55CB30EB.3050006@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 12/08/15 12:32, maitysanchayan at gmail.com wrote:
> Hello,
>
> On 15-08-12 11:41:55, Srinivas Kandagatla wrote:
>> >Hi Sanchayan,
>> >
>> >Please run checkpatch before you send the patch next time.
>> >Look at Documentation/SubmittingPatches for more details.
>> >
>> >WARNING: line over 80 characters
>> >#225: FILE: drivers/nvmem/vf610-ocotp.c:174:
>> >+			ret = vf610_ocotp_wait_busy(ocotp->base + OCOTP_CTRL_REG);
>> >
>> >WARNING: line over 80 characters
>> >#237: FILE: drivers/nvmem/vf610-ocotp.c:186:
>> >+			ret = vf610_ocotp_wait_busy(ocotp->base + OCOTP_CTRL_REG);
>> >
>> >WARNING: line over 80 characters
>> >#244: FILE: drivers/nvmem/vf610-ocotp.c:193:
>> >+				writel(OCOTP_CTRL_ERROR, ocotp->base + OCOTP_CTRL_CLR);
>> >
> I had. However splitting these lines seemed odd. Will split and fix.
>
Just get the base to a local variable, which should make it look neat 
and this will avoid de-referencing the octop in the all the time in loop.

--srini
