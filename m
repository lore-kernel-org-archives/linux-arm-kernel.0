From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Tue, 25 Nov 2014 12:02:05 +0530
Subject: [PATCH] opp: convert dev_warn() to dev_dbg() for duplicate OPPs
In-Reply-To: <42965945.ST26GKfzPz@vostro.rjw.lan>
References: <7017fa592bdaf73c260ad001a2b7abdc8d14f08a.1416211616.git.viresh.kumar@linaro.org>
 <5171628.FRGslOuEb6@vostro.rjw.lan>
 <CAKohpomz_UiRErSsDPLWcmU4e7ocXZZu7bwCF8TvoSJupikd7A@mail.gmail.com>
 <42965945.ST26GKfzPz@vostro.rjw.lan>
Message-ID: <CAKohponB8-7f345qHKW8+GZaBSr2sj7rG-M7QMaQdA9n0muUZQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 24 November 2014 at 20:39, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> I hope that doesn't happen under rcu_read_lock()?

No. Should it?

> The modification needs to be done under dev_opp_list_lock in the first place

Yeah, its there to protect against other updaters.

> in which case you don't need the _rcu version of list walking, so you simply
> can use list_for_each_entry_safe() here. The mutex is sufficient for the
> synchronization with other writers (if any).  The freeing, though, has to be

Correct.

> deferred until all readers drop their references to the old entry.  You can
> use kfree_rcu() for that.

Cool. I understood the concept atleast. And yes I followed the srcu mail from
paul as well.. Will reply there.
