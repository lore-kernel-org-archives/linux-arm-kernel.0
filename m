From: akpm@linux-foundation.org (Andrew Morton)
Date: Tue, 28 Oct 2014 14:18:05 -0700
Subject: [PATCH v3] rtc: omap: add support for pmic_power_en
In-Reply-To: <20141028083633.GM2006@localhost>
References: <1413913086-12730-1-git-send-email-johan@kernel.org>
 <1414397368-26480-1-git-send-email-johan@kernel.org>
 <20141027154031.4492ea11d401045ca04a3ff8@linux-foundation.org>
 <20141028083633.GM2006@localhost>
Message-ID: <20141028141805.7b67bba29734be326354957f@linux-foundation.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 28 Oct 2014 09:36:33 +0100 Johan Hovold <johan@kernel.org> wrote:

> > But it doesn't explain *why* we want the alarm to trigger before
> > returning.
> 
> Should we really require every power-off handler to document arch
> behaviour (even if its inconsistent and currently undocumented); in
> this case that some arches return to user-space where we may oops if
> called from process 0 (e.g. systemd, but not if using sysvinit)?

The kernel really doesn't have a problem related to excessive amounts
of useful code comments :(

The bottom line is: did I provide a reader with the ability to
understand why the code is this way?  If "no" then improvements beckon.

This does look like one code site where an elaborate explanation is
warranted.  There's no way in which a reader can get to your above
paragraph from the current rtc-omap.c.
