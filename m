From: thierry.reding@gmail.com (Thierry Reding)
Date: Mon, 2 Jul 2018 16:03:43 +0200
Subject: [PATCH v3 0/8] Tegra Combined UART driver
In-Reply-To: <20180702114033.15654-1-mperttunen@nvidia.com>
References: <20180702114033.15654-1-mperttunen@nvidia.com>
Message-ID: <20180702140343.GO13096@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 02, 2018 at 02:40:25PM +0300, Mikko Perttunen wrote:
> Hi, here's v3. Changes are in individual patches. Acks are still
> missing from the following patches:
> 
> mailbox: Add transmit done by blocking option
> mailbox: tegra-hsp: Refactor in preparation of mailboxes
> mailbox: tegra-hsp: Add support for shared mailboxes
> serial: Add Tegra Combined UART driver

There don't seem to be any build-time dependencies between the above, so
technically I guess these could be applied to the respective trees
separately. The only thing we need to be careful about is to not merge
the final patch before the others, because it will break serial console
if the other patches aren't applied.

Jassi, Greg,

What I could do to resolve the runtime dependency is pull the mailbox
patches into a separate branch, create another separate branch for the
TCU driver that is based on the mailbox branch and then base the DT
changes on that branch, or possibly send a separate pull request for
just the DT change late in the merge window or shortly after v4.19-rc1.

Obviously the latter would be equivalent to you guys merging the patches
through your trees for v4.19-rc1 and me sending out a late pull request
for the DT bits.

Any preference?

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180702/964ac526/attachment.sig>
