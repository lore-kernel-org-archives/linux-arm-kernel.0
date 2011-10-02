From: ohad@wizery.com (Ohad Ben-Cohen)
Date: Sun, 2 Oct 2011 20:48:41 +0200
Subject: [RFC 1/5] ARM: dev_archdata: add private iommu extension
In-Reply-To: <20110927013001.GA20588@ponder.secretlab.ca>
References: <1316948337-7924-1-git-send-email-ohad@wizery.com>
	<1316948337-7924-2-git-send-email-ohad@wizery.com>
	<20110927013001.GA20588@ponder.secretlab.ca>
Message-ID: <CAK=WgbY+YN6aj4+RUdPz068+H+vtnEx0_SbKuKc++S4AHRS_hw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 27, 2011 at 4:30 AM, Grant Likely <grant.likely@secretlab.ca> wrote:
> Blech. ?Oh well. ?Not much point in doing something different if x86
> uses a void*.

x86 probably does this because two different implementations needs to
plug their private data there: intel-iommu plugs there a 'struct
device_domain_info *' and amd_iommu uses it with a 'struct
iommu_dev_data *'.

On ARM we'd eventually end up with even a bigger variety, and I guess
that even if we'd use a type-safe member here, it would itself end up
having 'void *'.

If it looks reasonable to you, can I please have your Ack ?

Russell, can you please take a look too and ack/nack ?

Thanks,
Ohad.
