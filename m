From: alex.shi@linaro.org (Alex Shi)
Date: Tue, 17 Dec 2013 15:19:39 +0800
Subject: [PATCH 4/6] arm64: topology: Implement basic CPU topology support
In-Reply-To: <20131216152235.GI3185@sirena.org.uk>
References: <1386767606-6391-1-git-send-email-broonie@kernel.org>
 <1386767606-6391-4-git-send-email-broonie@kernel.org>
 <52AF11FE.70000@linaro.org> <20131216152235.GI3185@sirena.org.uk>
Message-ID: <52AFFB0B.3010505@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/16/2013 11:22 PM, Mark Brown wrote:
> On Mon, Dec 16, 2013 at 10:45:18PM +0800, Alex Shi wrote:
>> On 12/11/2013 09:13 PM, Mark Brown wrote:
> 
>>> +struct cputopo_arm {
>>> +	int thread_id;
>>> +	int core_id;
>>> +	int socket_id;
> 
>> Forgive me if I am stupid. :)
> 
>> why we don't need a cluster_id? and does one cpu socket include few
>> clusters?
> 
> The ARMv7 code calls a cluster a socket I think because it's trying to
> maintain similarity with other architectures and the ARMv8 code follows
> ARMv7 in this regard.  At the minute we're using this ID for whatever
> the lowest level of grouping is above a core and presenting the
> scheduler with a flat topology there - the topology binding and MPIDR
> both allow multiple layers of cluster so you could definitely have
> multiple clusters in a supercluster.
> 
> Without practical examples of such systems or more architecture
> documentation than I've been able to find it's not clear how to
> represent them to the scheduler, it will depend on how closely
> associated the clusters are and what the scheduler's features are,
> perhaps we should describe such a system as NUMA but it's not clear to
> me that this would produce the desired results.  I wonder if we may end
> up figuring this out from other data such as descriptions of caches and
> interconnects rather than purely from the topology information.

For topology meaning, it may be better to have cluster concept there.
And don't know if there will has a real ARM NUMA system for 64bit
server. If so, socket_id is good in a NUMA system.


-- 
Thanks
    Alex
