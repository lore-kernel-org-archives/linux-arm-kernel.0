From: grant.likely@linaro.org (Grant Likely)
Date: Mon, 15 Sep 2014 10:52:50 -0700
Subject: [PATCH v4 10/18] ACPI / table: Print GIC information when MADT
 is parsed
In-Reply-To: <20140915064010.GD26649@localhost>
References: <1410530416-30200-1-git-send-email-hanjun.guo@linaro.org>
 <1410530416-30200-11-git-send-email-hanjun.guo@linaro.org>
 <20140915064010.GD26649@localhost>
Message-ID: <20140915175250.8177DC40A42@trevor.secretlab.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 14 Sep 2014 23:40:10 -0700, Olof Johansson <olof@lixom.net> wrote:
> On Fri, Sep 12, 2014 at 10:00:08PM +0800, Hanjun Guo wrote:
> > When MADT is parsed, print GIC information to make the boot
> > log look pretty.
> 
> If you do this for prettiness, having an example output in the commit
> message would be a nice touch.

Agreed.

> The question is why it's needed though? Do we really need all this verbose
> information in dmesg when it could be found out in other ways instead?
> 
> x86 is notoriously verbose in some of these aspects, I'm not sure it's
> something we need to mimic here?

For consistency, it does make sense to have the common x86 and ARM64
code outputing information in the same way, so I think the patch still
makes sense. All of them could be moved to KERN_DEBUG as a separate
patch if we want to cull early boot output. I would split that off and
discuss it separately.

g.
