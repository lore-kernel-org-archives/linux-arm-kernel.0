From: lee.jones@linaro.org (Lee Jones)
Date: Mon, 11 Jun 2012 11:27:53 +0100
Subject: [PATCH 08/22] regulator: Change ab8500 match names to reflect
 Device Tree
In-Reply-To: <20120605103846.GQ23408@opensource.wolfsonmicro.com>
References: <20120530100302.GD9947@opensource.wolfsonmicro.com>
 <CAF2Aj3gZMF9ev9B46rBM+aY-srwthef09ad2CWfuXXFHmqqAjA@mail.gmail.com>
 <20120530121547.GJ9947@opensource.wolfsonmicro.com>
 <4FC63632.4030504@linaro.org>
 <20120530151119.GN9947@opensource.wolfsonmicro.com>
 <4FC63B39.6040905@linaro.org>
 <20120530164152.GP9947@opensource.wolfsonmicro.com>
 <4FC846CC.20801@linaro.org>
 <20120601084850.GJ24139@opensource.wolfsonmicro.com>
 <4FCDDFFC.3000902@linaro.org>
 <20120605103846.GQ23408@opensource.wolfsonmicro.com>
Message-ID: <4FD5C829.2090408@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/06/12 11:38, Mark Brown wrote:
> On Tue, Jun 05, 2012 at 11:31:24AM +0100, Lee Jones wrote:
>> On 01/06/12 09:48, Mark Brown wrote:
>
>>> What makes you say the two are equivalent?  The former is a reference
>> >from a consumer device to a named regulator while the latter is a
>>> reference from a regulator to a named consumer.
>
>> I mean they both link regulator<->consumer and apply the name "vmmc"
>> to the supply, or am I missing something / getting confused?
>
> You're missing something - note what I say above about the direction the
> mapping is done in, and consider what happens if we've got two of the
> same PMIC down in a system.

I'm still not seeing how this would cause an issue. The only Device Tree 
nodes which will be parsed are the ones which are specified by a 
particular driver's compatible string, meaning that any other nodes 
referencing similar regulator/supply names would be ignored. In case I 
am still missing a critical point here, would you be kind enough to 
provide an example that we can work though together?

-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
M: +44 77 88 633 515
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
