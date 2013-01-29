From: mfuzzey@parkeon.com (Martin Fuzzey)
Date: Tue, 29 Jan 2013 16:46:08 +0100
Subject: [PATCH V3  0/5] W1: Support onewire master on i.MX53
Message-ID: <20130129154608.5184.46101.stgit@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

W1: Support onewire master on i.MX53
	* Add device tree and pinctrl support to the MXC master driver
	* Convert to use devm_
	* Add i.MX53 clocks
	* Add i.MX53 device tree entries

Changes since V2
* Add documentation on device tree binding
* Add Acked-bys from Sascha and Evgeniy

Changes since V1
* Applied comments from Sascha Hauer:
	* Move patch converting driver to devm_ before the one adding devm_ based pinctrl
	* Fix existing unbalanced clk_prepare_enable/clk_disable_unprepare
	in probe error path

* Place DT patch last since it includes pinctrls for driver.
