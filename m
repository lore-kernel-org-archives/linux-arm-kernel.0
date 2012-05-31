From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 31 May 2012 08:42:12 +0800
Subject: [PATCH 08/22] regulator: Change ab8500 match names to reflect
 Device Tree
In-Reply-To: <20120530164152.GP9947@opensource.wolfsonmicro.com>
References: <1338353260-10097-1-git-send-email-lee.jones@linaro.org>
 <1338353260-10097-9-git-send-email-lee.jones@linaro.org>
 <CACRpkdbQv8Q07iRAmG3UQRm7UNDi_Y+s_vvACDKKxR9tg+1iqg@mail.gmail.com>
 <20120530100302.GD9947@opensource.wolfsonmicro.com>
 <CAF2Aj3gZMF9ev9B46rBM+aY-srwthef09ad2CWfuXXFHmqqAjA@mail.gmail.com>
 <20120530121547.GJ9947@opensource.wolfsonmicro.com>
 <4FC63632.4030504@linaro.org>
 <20120530151119.GN9947@opensource.wolfsonmicro.com>
 <4FC63B39.6040905@linaro.org>
 <20120530164152.GP9947@opensource.wolfsonmicro.com>
Message-ID: <4FC6BE64.6030201@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 31/05/12 00:41, Mark Brown wrote:
> On Wed, May 30, 2012 at 11:22:33PM +0800, Lee Jones wrote:
>> On 30/05/12 23:11, Mark Brown wrote:
>
>>>> 	vin-supply =<&db8500_vape_reg>;
>>>> 	vmmc-supply =<&ab8500_ldo_aux2_reg>;
>
>>> Oh, oops.  This is going to be fun when someone puts down two of the
>>> same PMIC on a system...
>
>> What does that mean sorry?
>
> Lots of regulators are using this mechanism for identifying child nodes.
> If the node name is also used as a handle by other things to reference
> the regulator then if you have two PMICs of the same type DTC isn't
> going to be able to figure out which node you mean.

I haven't looked at the code yet, so I don't know the answer to this 
question, but; aren't they protected by the compatible string? If not, I 
think they should be. We shouldn't be parsing other platform's Device Trees.

-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
M: +44 77 88 633 515
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
