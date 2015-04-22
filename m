From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Wed, 22 Apr 2015 09:55:07 +0100
Subject: [RFC PATCH v2 0/1] ARM: cpuidle: heterogeneous systems extension
In-Reply-To: <CAMAWPa_fMhgFfL8krDxT9h42mydVogkaYQt1Me1qJTsKeH5dSA@mail.gmail.com>
References: <1429200617-9546-1-git-send-email-lorenzo.pieralisi@arm.com>
 <CAMAWPa_fMhgFfL8krDxT9h42mydVogkaYQt1Me1qJTsKeH5dSA@mail.gmail.com>
Message-ID: <20150422085507.GA22601@red-moon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 21, 2015 at 07:24:54PM +0100, Kevin Hilman wrote:
> On Thu, Apr 16, 2015 at 9:10 AM, Lorenzo Pieralisi
> <lorenzo.pieralisi@arm.com> wrote:
> 
> [...]
> 
> > This patch sets the maximum number of static CPUidle drivers allowed to
> > two, since it is hard to foresee systems with more than two sets of CPUs
> > having different idle states
> 
> It's not hard to forsee anymore:
> 
>    http://www.cnx-software.com/2015/04/21/mediatek-helio-x20-deca-core-processor/
>    https://liliputing.com/2015/04/closer-look-at-mediateks-upcoming-10-core-helio-x20-processor.html

Eheh I stand corrected :). Not a big deal, drivers can be allocated
dynamically; it seems that the designs above leave us no choice, the
idle states are the only differentiating factor when it comes
to CPUidle driver logical cpumask creation, happy to hear more
opinions on this, but I do not really see what we can use instead.

Thanks,
Lorenzo
