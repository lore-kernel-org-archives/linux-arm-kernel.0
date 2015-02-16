From: mlangsdo@redhat.com (Mark Langsdorf)
Date: Mon, 16 Feb 2015 13:44:46 -0600
Subject: Occasional crash in APM xgene enet driver
In-Reply-To: <20150215151046.GA8034@cbox>
References: <20150215151046.GA8034@cbox>
Message-ID: <54E248AE.4060405@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/15/2015 09:10 AM, Christoffer Dall wrote:
> Hi,
>
> For a while now, I've been seeing occasional crashes in the ethernet
> driver when running mainline on the APM X-Gene systems.
>
> I've seen this with mainline since somewhere in v3.17 and on several
> hardware boards stress testing KVM by running workloads in VMs.
>
> Alex Bennee (cc'ed) is also seeing this from time to time.
>
> Here is one of the crashes, I can begin collecting more if that helps.
> Let me know if we can help in other ways to trace down the issue.
>
> Config is defconfig + CONFIG_BRIDGE=y.

This looks like the out of order descriptor bytes read bug
fixed in:

commit ecf6ba83d76e0c78e89401750dc527008e14faa2
Author: Iyappan Subramanian <isubramanian@apm.com>
Date:   Thu Jan 29 14:38:23 2015 -0800
drivers: net: xgene: fix: Out of order descriptor bytes read

You should update to 3.19 and see if you still see the problem.
We were seeing it daily until we added that patch and it has
since gone away.

--Mark Langsdorf
