From: peter.maydell@linaro.org (Peter Maydell)
Date: Sat, 11 May 2013 17:31:32 +0100
Subject: [PATCH v3 30/32] arm64: KVM: enable initialization of a 32bit vcpu
In-Reply-To: <CAEDV+gKJg9r+fwiqRAKrQdMVooXCUfKMdog-xveLnBkOgE+YUQ@mail.gmail.com>
References: <1365437854-30214-1-git-send-email-marc.zyngier@arm.com>
 <1365437854-30214-31-git-send-email-marc.zyngier@arm.com>
 <20130423230229.GN20569@gmail.com> <5177E303.7050801@arm.com>
 <CAEDV+g+OL+37w9jA8=0WGea5FgW5y3mazqFzv9GLxDgjCe6dtg@mail.gmail.com>
 <51892DA4.4050401@arm.com> <20130511003842.GE30999@chazy>
 <CAFEAcA-8cHk9Gv5j8XvK9dfkpZJeZ+hNfc4NekKCW_KBeHttKg@mail.gmail.com>
 <CAEDV+gKJg9r+fwiqRAKrQdMVooXCUfKMdog-xveLnBkOgE+YUQ@mail.gmail.com>
Message-ID: <CAFEAcA-GvE_r-Pk-9uYQEK48ZZAxmvhFewPLYS9cDfnnC==x=Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11 May 2013 17:26, Christoffer Dall <cdall@cs.columbia.edu> wrote:
> I just think that saying "EINVAL: Invalid argument" for a perfectly
> valid argument which is just not supported on this hardware is what's
> wrong, I think ENXIO or ENODEV or whatever is more appropriate of
> this.

That's fine with me. I don't mind as long as we document what
errnos we're using and (ideally) cleanly separate the different
things we're trying to report. At the moment QEMU doesn't try to
do anything clever with the errno at all anyway...

-- PMM
