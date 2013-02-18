From: srivatsa.bhat@linux.vnet.ibm.com (Srivatsa S. Bhat)
Date: Mon, 18 Feb 2013 18:09:32 +0530
Subject: [PATCH v6 09/46] CPU hotplug: Convert preprocessor macros to static
 inline functions
In-Reply-To: <20130218123714.26245.61816.stgit@srivatsabhat.in.ibm.com>
References: <20130218123714.26245.61816.stgit@srivatsabhat.in.ibm.com>
Message-ID: <20130218123932.26245.15573.stgit@srivatsabhat.in.ibm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/05/2012 06:10 AM, Andrew Morton wrote:
"static inline C functions would be preferred if possible.  Feel free to
fix up the wrong crufty surrounding code as well ;-)"

Convert the macros in the CPU hotplug code to static inline C functions.

Signed-off-by: Srivatsa S. Bhat <srivatsa.bhat@linux.vnet.ibm.com>
Reviewed-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
---

 include/linux/cpu.h |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/linux/cpu.h b/include/linux/cpu.h
index cf24da1..eb79f47 100644
--- a/include/linux/cpu.h
+++ b/include/linux/cpu.h
@@ -198,10 +198,10 @@ static inline void cpu_hotplug_driver_unlock(void)
 
 #else		/* CONFIG_HOTPLUG_CPU */
 
-#define get_online_cpus()	do { } while (0)
-#define put_online_cpus()	do { } while (0)
-#define get_online_cpus_atomic()	do { } while (0)
-#define put_online_cpus_atomic()	do { } while (0)
+static inline void get_online_cpus(void) {}
+static inline void put_online_cpus(void) {}
+static inline void get_online_cpus_atomic(void) {}
+static inline void put_online_cpus_atomic(void) {}
 #define hotcpu_notifier(fn, pri)	do { (void)(fn); } while (0)
 /* These aren't inline functions due to a GCC bug. */
 #define register_hotcpu_notifier(nb)	({ (void)(nb); 0; })
