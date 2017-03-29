From: sebastian.siewior@linutronix.de (Sebastian Andrzej Siewior)
Date: Wed, 29 Mar 2017 18:10:40 +0200
Subject: [PATCH 1/1] tty: serial: st-asc: Make the locking RT aware
In-Reply-To: <1490202751-16581-1-git-send-email-lionel.debieve@st.com>
References: <1490202751-16581-1-git-send-email-lionel.debieve@st.com>
Message-ID: <20170329161040.ktv4qpiyhjfjzdss@linutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2017-03-22 18:12:31 [+0100], Lionel Debieve wrote:
> The lock is a sleeping lock and local_irq_save() is not the
> standard implementation now. Working for both -RT and non
> RT.
> 
> Signed-off-by: Lionel Debieve <lionel.debieve@st.com>

Acked-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

This is how serial8250_console_write() looks upstream, too.

Sebastian
