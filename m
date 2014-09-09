From: jcm@redhat.com (Jon Masters)
Date: Tue, 09 Sep 2014 02:27:24 -0400
Subject: [PATCH v3 13/17] ARM64 / ACPI: Add GICv2 specific ACPI boot
 support
In-Reply-To: <4895927.Zp4WL2AZAF@wuerfel>
References: <1409583475-6978-1-git-send-email-hanjun.guo@linaro.org>
 <5405BFE7.5060005@arm.com> <5406DEB6.1060705@linaro.org>
 <4895927.Zp4WL2AZAF@wuerfel>
Message-ID: <540E9DCC.4080903@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/03/2014 10:57 AM, Arnd Bergmann wrote:
> On Wednesday 03 September 2014 11:26:14 Tomasz Nowicki wrote:

> In particular, the ACPI tables describing the irqchip have no way to
> identify the GIC at all, if I read the spec correctly, you have to
> parse the tables, ioremap the registers and then read the ID to know
> if you have GICv1/v2/v2m/v3/v4. There doesn't seem to be any "device"
> for the GIC that a hypothetical probe function would be based on.

(aside) I have already noticed this and am separately raising a request
to have this dealt with in the specification at a later time. I believe
it's fairly contrived, since I don't think it'll be at all common to
have a GICv3/v4 IP implementation that has a CPU interface defined.

The problem (not now, but in later implementations that actually have
GICv3/v4 hardware is making assumptions since even a GICv3 or GICv4
system could implement a legacy compatibility mode in which the memory
register interface is defined and mappable so you would be valid in
having defined memory addresses in the MADT linked structures then.

Jon.
