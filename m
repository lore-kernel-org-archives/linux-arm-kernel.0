From: robh@kernel.org (Rob Herring)
Date: Tue, 25 Sep 2018 13:17:35 -0500
Subject: [PATCH v9 5/8] interconnect: qcom: Add RPM communication
In-Reply-To: <20180831140151.13972-6-georgi.djakov@linaro.org>
References: <20180831140151.13972-1-georgi.djakov@linaro.org>
 <20180831140151.13972-6-georgi.djakov@linaro.org>
Message-ID: <20180925181735.GA28385@bogus>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 31, 2018 at 05:01:48PM +0300, Georgi Djakov wrote:
> On some Qualcomm SoCs, there is a remote processor, which controls some of
> the Network-On-Chip interconnect resources. Other CPUs express their needs
> by communicating with this processor. Add a driver to handle communication
> with this remote processor.

I don't think you should have a binding nor a separate driver for this. 
It's not actually an interconnect provider, so it doesn't belong in 
bindings/interconnect. And it just looks like abuse of DT to instantiate 
some driver.

All the driver amounts to is a 1 function wrapper for RPM_KEY_BW 
messages. Can't this be part of the parent?

Rob
