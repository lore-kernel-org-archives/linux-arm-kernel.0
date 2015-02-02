From: edubezval@gmail.com (Eduardo Valentin)
Date: Mon, 2 Feb 2015 14:22:15 -0400
Subject: [PATCHv2 1/1] cpufreq: exynos: allow modular build
In-Reply-To: <CAKohpondsvLm2S_V+aBSoCg252nHONJ6TbyTuHoVYuwxBDEuDA@mail.gmail.com>
References: <1422730782-13055-1-git-send-email-edubezval@gmail.com>
 <CAKohpondsvLm2S_V+aBSoCg252nHONJ6TbyTuHoVYuwxBDEuDA@mail.gmail.com>
Message-ID: <20150202182213.GF17425@developer.hsd1.ca.comcast.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 02, 2015 at 09:33:09AM +0530, Viresh Kumar wrote:
> On 1 February 2015 at 00:29, Eduardo Valentin <edubezval@gmail.com> wrote:
> > From: Arnd Bergmann <arnd@arndb.de>
> >

<big cut>

> 
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

Thanks!

> 
> Now as these are all compilable as modules, should we look into the drivers as
> well to see what they are doing on module unload ?

hmm.. it seams to be the case, yes. From a quick look, there are unreleased resources
that needs to be freed. However, they are not really on module unload,
but on device removal. Which should be a reproducible but even today, in
case one manually unbinds the device.

Let me have a look here and will be sending something soon.


Thanks,

Eduardo Valentin

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150202/b3f7e5ad/attachment.sig>
