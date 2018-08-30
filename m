From: jbrunet@baylibre.com (Jerome Brunet)
Date: Thu, 30 Aug 2018 10:56:05 +0200
Subject: [PATCH v2 2/2] PCI: meson: add the Amlogic Meson PCIe phy driver
In-Reply-To: <b8deb2ef-5e73-b508-616e-b0303a0adc78@amlogic.com>
References: <1535096006-152091-1-git-send-email-hanjie.lin@amlogic.com>
 <1535096006-152091-3-git-send-email-hanjie.lin@amlogic.com>
 <c21a2e25c934d19f913f625542f505cf45754f23.camel@baylibre.com>
 <b8deb2ef-5e73-b508-616e-b0303a0adc78@amlogic.com>
Message-ID: <2558005d0cad11feb9d6775b2ed237351098fa06.camel@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2018-08-30 at 16:02 +0800, Hanjie Lin wrote:
> > I thought you said there was only phy on this platform.
> > If that's the case, what is this reset shared with ?
> 
> Amlogic axg soc includes two pcie controllers and they share the same pcie phy.
> Because of two pcie controllers, meson_pcie_phy_probe() will be called two times.
> So, the phy reset must be shared.

You are abusing the API then.
The phy should have exclusive control of its *own* reset line, not other device
should claim this reset. 
I should then manage the fact that it may have more than one consumer.
