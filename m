From: sarah.a.sharp@linux.intel.com (Sarah Sharp)
Date: Fri, 17 Jan 2014 12:54:32 -0800
Subject: [BUG] FL1009: xHCI host not responding to stop endpoint command.
In-Reply-To: <87zjmvau23.fsf@nemi.mork.no>
References: <87eh4dot61.fsf@natisbad.org> <87sissopaf.fsf@natisbad.org>
 <20140114170719.GA12126@xanatos> <87bnzekz5l.fsf@natisbad.org>
 <063D6719AE5E284EB5DD2968C1650D6D45C5AB@AcuExch.aculab.com>
 <87mwix5anm.fsf@natisbad.org> <20140116185044.GC18392@xanatos>
 <87fvon2khn.fsf@natisbad.org> <87zjmvau23.fsf@nemi.mork.no>
Message-ID: <20140117205432.GB5618@xanatos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 17, 2014 at 09:31:16AM +0100, Bj?rn Mork wrote:
> arno at natisbad.org (Arnaud Ebalard) writes:
> > Sarah Sharp <sarah.a.sharp@linux.intel.com> writes:
> >
> >>> ... AFAICT, this is exactly what commit 35773dac5f86 does and reverting
> >>> it does not help. If I am mistaken, can you point which part you want me
> >>> to remove in the code to test?
> >>> 
> >>> I am slowly starting to see a bisect session coming ;-)
> >>
> >> Try reverting commit 60e102ac73cd40069d077014c93c86dc7205cb68.
> >
> > AFAICT, this commit does not exist in master (Linus tree), i.e. it is
> > not in 3.13.0-rc8.
> 
> That commit is a stable backport of 9df89d85b407690afa46ddfbccc80bec6869971d 
> which is in v3.13-rc8:
> 
> bjorn at nemi:/usr/local/src/git/linux$ git tag --contains 9df89d85b407690afa46ddfbccc80bec6869971d
> usb-3.13-rc1
> usb-3.13-rc3
> usb-3.13-rc5
> v3.13-rc1
> v3.13-rc2
> v3.13-rc3
> v3.13-rc4
> v3.13-rc5
> v3.13-rc6
> v3.13-rc7
> v3.13-rc8

Sorry for using the stable commit ID.  Arnaud, please try reverting
commit 9df89d85b407690afa46ddfbccc80bec6869971d "usbcore: set
lpm_capable field for LPM capable root hubs" and see if it fixes your
issues.

Sarah Sharp
