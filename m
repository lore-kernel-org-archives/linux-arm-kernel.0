From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Wed, 30 Nov 2011 11:41:58 +0000
Subject: [ANNOUNCE] Xen port to Cortex-A15 / ARMv7 with virt extensions
In-Reply-To: <CAAhSdy3F1oUQP=f_Tig4_MnufwPRpNooZYW8_cSTAse7aOaDoA@mail.gmail.com>
References: <alpine.DEB.2.00.1111281009090.31179@kaball-desktop>
 <201111292129.20444.arnd@arndb.de>
 <CAAhSdy3F1oUQP=f_Tig4_MnufwPRpNooZYW8_cSTAse7aOaDoA@mail.gmail.com>
Message-ID: <alpine.DEB.2.00.1111301112400.31179@kaball-desktop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 30 Nov 2011, Anup Patel wrote:
> Hi all,
> 
> I wanted to know how Xen-ARM for A15 will address following concerns:
> 
> - How will Xen-ARM for A15 support legacy guest environment like ARMv5 or ARMv6 ?

It is not our focus at the moment; we are targeting operating systems
that support a modern ARMv7 machine with GIC support. 
That said, it might be possible to run legacy guests in the future,
introducing more emulation to the hypervisor.


> - What if my Cortex-A15 board does not have a GIC with virtualization support ?

We expect most hardware vendors to provide a GIC with virtualization
support. However if they do not, in order to support their boards we'll
have to do more emulation in the hypervisor.
