From: will.deacon@arm.com (Will Deacon)
Date: Wed, 10 Sep 2014 19:30:03 +0100
Subject: [PATCH v3 04/17] ARM64 / ACPI: Introduce early_param for "acpi"
In-Reply-To: <CAErSpo58eWadcyTrsBPAa-QFNmWn5jO7yQGc=N6F6PgNXnXcJA@mail.gmail.com>
References: <1409583475-6978-1-git-send-email-hanjun.guo@linaro.org>
 <1409583475-6978-5-git-send-email-hanjun.guo@linaro.org>
 <CAErSpo6G89mkPgas8Wk3ofq__dUo5MKvBjob5D_w5_GaBJWH0w@mail.gmail.com>
 <540F7BE2.8060403@redhat.com> <20140910130419.GJ28488@arm.com>
 <CAErSpo58eWadcyTrsBPAa-QFNmWn5jO7yQGc=N6F6PgNXnXcJA@mail.gmail.com>
Message-ID: <20140910183003.GN1710@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 10, 2014 at 02:21:59PM +0100, Bjorn Helgaas wrote:
> On Wed, Sep 10, 2014 at 7:04 AM, Will Deacon <will.deacon@arm.com> wrote:
> 
> > It's blindingly obvious that acpi=off is there to disable ACPI at boot.
> > We either support that option or we don't -- none of this `oh, well you
> > can use it in this specific case I suppose' rubbish. I'm not questioning
> > your use-case, but there's really no need to talk about an `orderly
> > adoption' when all you need to say is that your ACPI is busted and passing
> > acpi=off lets you boot with a devicetree.
> 
> Maybe we should set a taint bit or give some other indication that
> we're using a flag to work around breakage.

That sounds like a good idea. Working around breakage is a fact of life,
but the taint indicates that it's not the ideal behaviour.

Will
