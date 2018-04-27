From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 27 Apr 2018 11:13:46 +0100
Subject: [PATCHv3 02/11] arm64/kvm: consistently handle host HCR_EL2 flags
In-Reply-To: <20180427095139.GH13249@C02W217FHV2R.local>
References: <20180417183735.56985-1-mark.rutland@arm.com>
 <20180417183735.56985-3-mark.rutland@arm.com>
 <20180427095139.GH13249@C02W217FHV2R.local>
Message-ID: <20180427101346.nabhblz3csp3cy36@lakrids.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 27, 2018 at 11:51:39AM +0200, Christoffer Dall wrote:
> On Tue, Apr 17, 2018 at 07:37:26PM +0100, Mark Rutland wrote:
> > In KVM we define the configuration of HCR_EL2 for a VHE HOST in
> > HCR_HOST_VHE_FLAGS, but we don't ahve a similar definition for the
> 
> nit: have
> 
> > non-VHE host flags, and open-code HCR_RW. Further, in head.S we
> > open-code the flags for VHE and non-VHE configurations.
> > 
> > In future, we're going to want to configure more flags for the host, so
> > lets add a HCR_HOST_NVHE_FLAGS defintion, adn consistently use both
> 
> nit: and
> 

Sorry about those; fixed up now.

[...]

> Reviewed-by: Christoffer Dall <christoffer.dall@arm.com>

Cheers!

Mark.
