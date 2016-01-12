From: eric.dumazet@gmail.com (Eric Dumazet)
Date: Tue, 12 Jan 2016 14:34:48 -0800
Subject: [PATCHv2] net: bpf: reject invalid shifts
In-Reply-To: <20160112195356.GA34598@ast-mbp.thefacebook.com>
References: <20160112185121.GA34045@ast-mbp.thefacebook.com>
 <1452626228-15742-1-git-send-email-rabin@rab.in>
 <1452628118.1223.25.camel@edumazet-glaptop2.roam.corp.google.com>
 <20160112195356.GA34598@ast-mbp.thefacebook.com>
Message-ID: <1452638088.1223.28.camel@edumazet-glaptop2.roam.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2016-01-12 at 11:53 -0800, Alexei Starovoitov wrote:
> On Tue, Jan 12, 2016 at 11:48:38AM -0800, Eric Dumazet wrote:

> > 
> > I believe we should add a one time warning to give a clue to poor users
> > hitting this problem.
> 
> you mean like warn_on_once() here?
> Makes sense I guess.


pr_err(DEPRECATED, "%s (pid %d) "
                   "invalid shift in BPF program.\n"
                   current->comm, task_pid_nr(current));

Or something like that.
