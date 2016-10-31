From: khilman@baylibre.com (Kevin Hilman)
Date: Mon, 31 Oct 2016 14:46:17 -0600
Subject: [PATCH v2 4/5] ARM: dts: da850-lcdk: enable mstpri and ddrctl
 nodes
In-Reply-To: <12222113.L5elJM2tqN@avalon> (Laurent Pinchart's message of "Mon,
 31 Oct 2016 22:22:54 +0200")
References: <1477925138-23457-1-git-send-email-bgolaszewski@baylibre.com>
 <1477925138-23457-5-git-send-email-bgolaszewski@baylibre.com>
 <12222113.L5elJM2tqN@avalon>
Message-ID: <m2mvhk1c2u.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Laurent Pinchart <laurent.pinchart@ideasonboard.com> writes:

> Hi Bartosz,
>
> Thank you for the patch.
>
> On Monday 31 Oct 2016 15:45:37 Bartosz Golaszewski wrote:
>> Enable the MSTPRI configuration and DDR2/mDDR memory controller
>> nodes on da850-lcdk. This is needed in order to adjust the memory
>> throughput constraints for better tilcdc support.
>
> Is there a reason not to enable these unconditionally in da850.dtsi (or rather 
> not disabling them) instead of handling it per board ?

Right.  They should be enabled by default in DT.  The drivers already
have board-specific compatible checks.

Kevin
