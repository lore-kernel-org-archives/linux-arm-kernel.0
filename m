From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Sun, 4 Oct 2015 10:54:01 +0100
Subject: [PATCH V5 1/2] ACPI / EC: Fix broken 64bit big-endian users of
 'global_lock'
In-Reply-To: <CAJZ5v0imYBPVNfVjkgX1r8a1x6QbY4LtRcS7BNsGzg5=yuPRfA@mail.gmail.com>
References: <8d3d3428c3a36f821e4c3d8563d094ca4b4763fd.1443304934.git.viresh.kumar@linaro.org>
 <CAJZ5v0imYBPVNfVjkgX1r8a1x6QbY4LtRcS7BNsGzg5=yuPRfA@mail.gmail.com>
Message-ID: <20151004095401.GA29706@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Sep 27, 2015 at 03:48:24PM +0200, Rafael J. Wysocki wrote:
> On Sun, Sep 27, 2015 at 12:04 AM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > global_lock is defined as an unsigned long and accessing only its lower
> > 32 bits from sysfs is incorrect, as we need to consider other 32 bits
> > for big endian 64-bit systems. There are no such platforms yet, but the
> > code needs to be robust for such a case.
> >
> > Fix that by changing type of 'global_lock' to u32.
> >
> > Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> 
> Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Greg, please take this one along with the [2/2] if that one looks good to you.

Thanks, will do.

greg k-h
