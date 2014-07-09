From: hdegoede@redhat.com (Hans de Goede)
Date: Wed, 09 Jul 2014 09:22:23 +0200
Subject: [PATCH v9 3/7] ata: libahci: allow to use multiple PHYs
In-Reply-To: <20140708134000.GC4979@htj.dyndns.org>
References: <1404728173-20263-1-git-send-email-antoine.tenart@free-electrons.com>
 <1404728173-20263-4-git-send-email-antoine.tenart@free-electrons.com>
 <20140708134000.GC4979@htj.dyndns.org>
Message-ID: <53BCEDAF.8090308@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 07/08/2014 03:40 PM, Tejun Heo wrote:
> (Cc'ing Hans.)

Thanks for adding me to the loop.

I've been reading the entire thread sofar, and here are my 2 cents:

1) I think overall this is a good idea, and I like the suggested dt representation
2) I agree with Tejun that it would be better to tie the phy to the port, and thus to
add the struct phy * pointer to struct ahci_port_priv.

One question 2 brings with it is how to deal with older device-tree files which
have the phy directly in the ahci controller node. This seems to only be the
case for the TI dra7 and omap5 platforms. Probably those have only 1 sata port
(this needs to be verified), if that is the case we can simply hard code
tying the phy to port 0 in this case, and we should probably also update their
dts files in the kernel tree to use the new structure (while keeping the
ahci driver compatible with the old structure for now).

Regards,

Hans
