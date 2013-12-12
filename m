From: hanjun.guo@linaro.org (Hanjun Guo)
Date: Thu, 12 Dec 2013 19:22:42 +0800
Subject: [PATCH 4/6] arm64: topology: Implement basic CPU topology support
In-Reply-To: <20131212102757.GF11044@sirena.org.uk>
References: <1386767606-6391-1-git-send-email-broonie@kernel.org>
 <1386767606-6391-4-git-send-email-broonie@kernel.org>
 <20131211141224.GG26730@mudshark.cambridge.arm.com>
 <20131211141503.GX11468@sirena.org.uk>
 <20131211142431.GD596@darko.cambridge.arm.com> <52A95EE8.2060209@linaro.org>
 <20131212102757.GF11044@sirena.org.uk>
Message-ID: <52A99C82.6060704@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2013-12-12 18:27, Mark Brown wrote:
> On Thu, Dec 12, 2013 at 02:59:52PM +0800, Hanjun Guo wrote:
>> On 2013-12-11 22:24, Catalin Marinas wrote:
> 
>>> Lorenzo (on holiday now) pushed the DT topology bindings but there are
>>> no patches yet for reading them. I would much prefer to only describe
>>> the topology via DT rather than MPIDR (because hardware people sometimes
>>> have strange ideas).
> 
>> Topology code for ARM32 is based on MPIDR now, should we update it too with
>> describing the topology via DT?
> 
> Yes, the binding is supposed to apply to both so it'd be good to support
> it on pre-v8.  However using MPIDR should continue to be supported on
> pre-v8 as existing systems don't use the topology binding and so
> presumably have accurate MPIDRs, requiring the binding would be a
> regression for them.

Ah, that makes sense :)
