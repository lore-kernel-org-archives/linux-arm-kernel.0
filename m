From: broonie@kernel.org (Mark Brown)
Date: Tue, 17 Dec 2013 12:02:01 +0000
Subject: [PATCH 4/6] arm64: topology: Implement basic CPU topology support
In-Reply-To: <52AFFB0B.3010505@linaro.org>
References: <1386767606-6391-1-git-send-email-broonie@kernel.org>
 <1386767606-6391-4-git-send-email-broonie@kernel.org>
 <52AF11FE.70000@linaro.org> <20131216152235.GI3185@sirena.org.uk>
 <52AFFB0B.3010505@linaro.org>
Message-ID: <20131217120201.GR3185@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 17, 2013 at 03:19:39PM +0800, Alex Shi wrote:

> For topology meaning, it may be better to have cluster concept there.
> And don't know if there will has a real ARM NUMA system for 64bit
> server. If so, socket_id is good in a NUMA system.

The scheduler does have a separate NUMA node ID that we're not currently
using which I'd have expected to be a better fit for actual NUMA stuff;
looking at the options we've got it's not clear to me that with what the
scheduler has at the minute sockets aren't a good mapping for what the
hardware has.  There doesn't seem to be anything between threaded cores
and physical packages.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131217/d9dc0ae4/attachment-0001.sig>
