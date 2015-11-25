From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Wed, 25 Nov 2015 18:08:04 +0100
Subject: [PATCH net-next 3/3] net: mvneta: Add naive RSS support
In-Reply-To: <20151125175522.0e8dd8b8@free-electrons.com> (Thomas Petazzoni's
 message of "Wed, 25 Nov 2015 17:55:22 +0100")
References: <1448463243-21057-1-git-send-email-gregory.clement@free-electrons.com>
 <1448463243-21057-4-git-send-email-gregory.clement@free-electrons.com>
 <20151125175522.0e8dd8b8@free-electrons.com>
Message-ID: <871tbe9fd7.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thomas,
 
 On mer., nov. 25 2015, Thomas Petazzoni <thomas.petazzoni@free-electrons.com> wrote:

> Gregory,
>
> On Wed, 25 Nov 2015 15:54:03 +0100, Gregory CLEMENT wrote:
>
>>  	pp->rxq_def = rxq_def;
>>  
>> +	pp->indir[0] = rxq_def;
>
> So now we have the RX queue in both pp->rxq_def and pp->indir[0] ? Is
> this really useful ?

Currently pp->rxq_def and pp->indir are the same but only because there
is one entry in the indirection table. When the 256 entries will be used
then there won't be the same. But we will still need the rxq_def as the
mvneta IP need a reference to a default RX queue even for example for
MVNETA_PORT_CONFIG_DEFL_VALUE.

>
> Also, if the RX queue becomes a per-port definition, why do you keep
> the global rxq_def variable ?

The global rxq_def variable is used for the module parameter. Even if
we can change it latter, it is still good to be able to set the default
value, however the parameter is set at module level not at port level,
that why we still need this variable.

Thanks,

Gregory

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
