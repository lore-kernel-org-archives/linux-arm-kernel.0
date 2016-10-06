From: viro@ZenIV.linux.org.uk (Al Viro)
Date: Thu, 6 Oct 2016 22:37:34 +0100
Subject: [PATCH] Revert "debugfs: ->d_parent is never NULL or negative"
In-Reply-To: <1475789429-11414-1-git-send-email-okaya@codeaurora.org>
References: <1475789429-11414-1-git-send-email-okaya@codeaurora.org>
Message-ID: <20161006213734.GM19539@ZenIV.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 06, 2016 at 05:30:29PM -0400, Sinan Kaya wrote:
> This reverts commit acc29fb8f792 ("debugfs: ->d_parent is never NULL or
> negative") as it breaks the debugfs_remove_recursive API as show in the
> callstack below.

NAK.  Fix your code, don't break global asserts.
