From: mfuzzey@parkeon.com (Martin Fuzzey)
Date: Wed, 16 Jan 2013 15:57:49 +0100
Subject: [PATCH V2  0/5] W1: Support onewire master on i.MX53
Message-ID: <20130116145749.24249.678.stgit@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

W1: Support onewire master on i.MX53
	* Add device tree and pinctrl support to the MXC master driver
	* Convert to use devm_
	* Add i.MX53 clocks
	* Add i.MX53 device tree entries

Changes since V1
* Applied comments from Sascha Hauer:
	* Move patch converting driver to devm_ before the one adding devm_ based pinctrl
	* Fix existing unbalanced clk_prepare_enable/clk_disable_unprepare
	in probe error path

* Place DT patch last since it includes pinctrls for driver.
