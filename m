From: samitolvanen@google.com (Sami Tolvanen)
Date: Fri, 3 Nov 2017 13:18:23 -0700
Subject: [PATCH 07/15] arm64: use -mno-implicit-float instead of
 -mgeneral-regs-only
In-Reply-To: <CAGXu5jLAb+Jj7x8p0mizewoOHuQVqup9DxHkvgqkQFeB5cJo9w@mail.gmail.com>
References: <20171103171203.107569-1-samitolvanen@google.com>
 <20171103171203.107569-9-samitolvanen@google.com>
 <20171103183156.ando3jj5pl2hfk5j@lakrids.cambridge.arm.com>
 <20171103185222.k3c5kjo5m7dqieyg@lakrids.cambridge.arm.com>
 <CAGXu5jLAb+Jj7x8p0mizewoOHuQVqup9DxHkvgqkQFeB5cJo9w@mail.gmail.com>
Message-ID: <20171103201823.GB137924@samitolvanen.mtv.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 03, 2017 at 12:06:15PM -0700, Kees Cook wrote:
> Should a clang version test be included, since we know at least 5.0 is
> need (with this fix)? There are distros with much earlier versions of
> clang, for example...

Greg knows better, but I remember him mentioning that upstream clang
doesn't generate any worse code with -mno-implicit-float, so there should
be no harm in using this workaround with all versions.

This might change in future, of course, so I don't have objections to
adding a check for clang version < 6.0 here.

Sami
