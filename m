From: stephen@networkplumber.org (Stephen Hemminger)
Date: Tue, 22 Apr 2014 15:02:31 -0700
Subject: [PATCH 0/2] net: Add Keystone NetCP ethernet driver support
In-Reply-To: <1398201675-17379-1-git-send-email-santosh.shilimkar@ti.com>
References: <1398201675-17379-1-git-send-email-santosh.shilimkar@ti.com>
Message-ID: <20140422150231.2e87b7eb@nehalam.linuxnetplumber.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 22 Apr 2014 17:21:13 -0400
Santosh Shilimkar <santosh.shilimkar@ti.com> wrote:

> NetCP driver has a plug-in module architecture where each of the NetCP
> sub-modules exist as a loadable kernel module which plug in to the netcp
> core. These sub-modules are represented as "netcp-devices" in the dts
> bindings. It is mandatory to have the ethernet switch sub-module for
> the ethernet interface to be operational. Any other sub-module like the
> PA is optional.

Where is the implementation of these modules. You need to include
this as separate patch set. Also the hooks for these modules should all
be EXPORT_SYMBOL_GPL() to disallow proprietary modules.
