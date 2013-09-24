From: achin.gupta@arm.com (Achin Gupta)
Date: Tue, 24 Sep 2013 10:02:36 +0100
Subject: [Question] Verification For arm64: suspend/resume implementation
In-Reply-To: <5240F246.6050402@marvell.com>
References: <52327E41.1070904@marvell.com>
 <20130913144001.GA28531@e102568-lin.cambridge.arm.com>
 <524021EC.2000207@marvell.com>
 <20130923152606.GA6157@e102648.cambridge.arm.com>
 <5240F246.6050402@marvell.com>
Message-ID: <20130924090236.GY10174@e102648.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Leo,

On Tue, Sep 24, 2013 at 03:00:38AM +0100, Leo Yan wrote:
>
> On 09/23/2013 11:26 PM, Achin Gupta wrote:
>
> > The foundation model (if thats what you are using) does not model an
> > ARM cpu implementation. The CPUECTLR is a cpu specific register
> > (imp. def.)  so it is not present. The caches on the Foundation Model
> > are inherently coherent so you do not need to access this register. If
> > you do then the access is treated as an illegal instruction.
> >
>
> Thx for the info. So do u mean i need use FVP Model for A53?

I think you should use the dual cluster A57_A53 Base FVP models. They
have the power controller and model the CPUECTLR.SMP bit behaviour as
well.

>
> Here have another question, ARM have the example code for boot wrapper
> which will switch from EL3 to secure EL1 rather than non-secure's EL1?

I dont' think we do but let me check. Switching to S-EL1 instead of
NS-EL1 should be a matter of _not_ setting the SCR_EL3.NS bit before
doing the exception level change (ERET).

hth,
Achin

>
> Thx,
> Leo Yan
>
