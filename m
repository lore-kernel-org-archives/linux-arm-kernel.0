From: ldewangan@nvidia.com (Laxman Dewangan)
Date: Wed, 10 Jul 2013 12:33:51 +0530
Subject: [PATCH V2] ARM: tegra: enable gpio-keys on dalmore
In-Reply-To: <20130709060447.GA17499@mithrandir>
References: <1373102069-5641-1-git-send-email-ldewangan@nvidia.com>
 <20130709060447.GA17499@mithrandir>
Message-ID: <51DD0757.8060406@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 09 July 2013 11:34 AM, Thierry Reding wrote:
> * PGP Signed by an unknown key
>
> On Sat, Jul 06, 2013 at 02:44:29PM +0530, Laxman Dewangan wrote:
>> D
>> +
>> +		home {
>> +			label = "Home";
>> +			gpios = <&gpio TEGRA_GPIO(I, 5) GPIO_ACTIVE_LOW>;
>> +			linux,code = <102>; /* KEY_HOME */
> I wonder if these should maybe go into a header file as well so that
> symbolic names can be used. That'll make the value self-descriptive and
> allow the comment to be dropped.
>
Currently there is no header for input.h in dt-binding include. We need 
to add them first and then use it.
Probably it can be done along with all cleanups on dts file atleast for 
Tegra.
I can start this if no one faster than me for this activity but for this 
patch, I like to go on legacy way.
