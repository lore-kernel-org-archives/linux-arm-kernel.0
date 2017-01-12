From: john@phrozen.org (John Crispin)
Date: Thu, 12 Jan 2017 09:23:14 +0100
Subject: [PATCH 0/4] ARM: dts: mt7623: Add initial Geek Force support
In-Reply-To: <3fecb422-8185-7ee0-c203-2bfdc4fd1393@phrozen.org>
References: <20170108133100.10428-1-afaerber@suse.de>
 <91f5ec74-1aa1-f2ad-24e9-14267cbe8498@phrozen.org>
 <d6bd3783-d124-9871-d3b4-93e366517895@suse.de>
 <3fecb422-8185-7ee0-c203-2bfdc4fd1393@phrozen.org>
Message-ID: <0bd6567e-1c5b-0ff6-d044-57d25e1a40d2@phrozen.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andreas,

had a look last night why the ethernet dtsi was not added and it
obviously was not added as we were waiting for the clk-mt2701 to be
merged. the ethernet dtsi will have phandles pointing at the clk nodes
which did not exist at the time. same is true for the PWM code.

i sat down last night and worked out what pending patches i still have
for mt7623 and out of the ~80 required to get v4.4 working i only need
around 10 for v4.10-rc1.

i started to rebase these patches last night and will have time to test
them tomorrow or early next week. as the pwrap node alone is around 200
lines of devicetree we need to figure out a way to add this to the dts
files without duplicating it. i'll try to post a series early next week
that we can then discuss and rebase your geekboard patches on.

	John
