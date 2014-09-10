From: bhelgaas@google.com (Bjorn Helgaas)
Date: Wed, 10 Sep 2014 07:21:59 -0600
Subject: [PATCH v3 04/17] ARM64 / ACPI: Introduce early_param for "acpi"
In-Reply-To: <20140910130419.GJ28488@arm.com>
References: <1409583475-6978-1-git-send-email-hanjun.guo@linaro.org>
 <1409583475-6978-5-git-send-email-hanjun.guo@linaro.org>
 <CAErSpo6G89mkPgas8Wk3ofq__dUo5MKvBjob5D_w5_GaBJWH0w@mail.gmail.com>
 <540F7BE2.8060403@redhat.com> <20140910130419.GJ28488@arm.com>
Message-ID: <CAErSpo58eWadcyTrsBPAa-QFNmWn5jO7yQGc=N6F6PgNXnXcJA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 10, 2014 at 7:04 AM, Will Deacon <will.deacon@arm.com> wrote:

> It's blindingly obvious that acpi=off is there to disable ACPI at boot.
> We either support that option or we don't -- none of this `oh, well you
> can use it in this specific case I suppose' rubbish. I'm not questioning
> your use-case, but there's really no need to talk about an `orderly
> adoption' when all you need to say is that your ACPI is busted and passing
> acpi=off lets you boot with a devicetree.

Maybe we should set a taint bit or give some other indication that
we're using a flag to work around breakage.

There's a big difference between parameters like "root=", "console=",
"quiet", etc., and the ones like "pci=nocrs", "pci=realloc",
"acpi=off".  The latter are basically workarounds for deficiencies in
Linux or the platform, and we should try really hard to minimize their
use.  We might need some of them as interim workarounds, but I don't
think we should regard their use as acceptable standard practice for
end users.

Bjorn
